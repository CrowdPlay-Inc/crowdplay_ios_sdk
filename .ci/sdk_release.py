#!/usr/bin/env python3
"""Public SDK build/publication and callback to the original private example jobs."""
import hashlib
import json
import os
from pathlib import Path
import re
import stat
import subprocess
import sys
import tarfile
import urllib.error
import urllib.parse
import urllib.request
import uuid

MONOREPO = 'CrowdPlay-Inc/monorepo'
LOCAL_NAMES = {'.git', '.DS_Store', '.cache', '.build', '.gradle', '.kotlin', '.idea', '.secrets', 'build',
               'gc_keys.json', 'credentials.json', 'key.properties', 'local.properties', 'report.xml'}
PRIVATE_SUFFIXES = ('.p8', '.p12', '.jks', '.keystore', '.ipa', '.dSYM.zip')


def local_file(name):
    return name in LOCAL_NAMES or name.startswith('.env') or name.endswith(PRIVATE_SUFFIXES)


def checksum(directory, paths=None):
    digest = hashlib.sha256()
    for path in sorted(directory.rglob('*') if paths is None else paths):
        relative = path.relative_to(directory)
        if relative.as_posix() == 'sdk-release.json' or relative.parts[0] == '.git':
            continue
        if any(local_file(part) for part in relative.parts):
            raise ValueError('Local or credential file in SDK export: ' + relative.as_posix())
        if path.is_symlink():
            try:
                target = path.resolve(strict=True)
            except (OSError, RuntimeError) as error:
                raise ValueError('Missing SDK symlink target: ' + relative.as_posix()) from error
            if not target.is_relative_to(directory.resolve()):
                raise ValueError('SDK symlink escapes its export: ' + relative.as_posix())
            content = os.readlink(path).encode()
        elif path.is_file():
            content = path.read_bytes()
        elif path.is_dir():
            continue
        else:
            raise ValueError('Unsupported SDK export entry: ' + relative.as_posix())
        digest.update(relative.as_posix().encode() + b'\0')
        # Git preserves only the executable bit and symlink type.
        mode = 'link' if path.is_symlink() else '755' if path.stat().st_mode & stat.S_IXUSR else '644'
        digest.update(mode.encode() + b'\0')
        digest.update(hashlib.sha256(content).digest())
    return digest.hexdigest()


def run(*args, cwd=None):
    result = subprocess.run([str(arg) for arg in args], cwd=cwd, text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f'{args[0]} failed with exit code {result.returncode}')
    return result.stdout.strip()


def gh(*args, input=None):
    token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_PUBLISH_PAT')
    if not token:
        raise ValueError('Missing GitHub publication token')
    result = subprocess.run(['gh', *args], input=input, text=True, capture_output=True,
                            env=dict(os.environ, GH_TOKEN=token))
    if result.returncode:
        raise RuntimeError(result.stderr.strip() or 'GitHub CLI request failed')
    return result.stdout.strip()


def github(repository, path, data=None):
    args = ['api', f'repos/{repository}/{path}']
    if data is not None:
        args.extend(['--method', 'POST', '--input', '-'])
    value = gh(*args, input=json.dumps(data) if data is not None else None)
    return json.loads(value) if value else None


def metadata(root=Path('.')):
    release = json.loads((root / 'sdk-release.json').read_text())
    platform = release['platform']
    repository = f'CrowdPlay-Inc/crowdplay_{platform}_sdk'
    # Native builds create ignored caches; only Git-tracked files are published.
    files = [root / name for name in run('git', 'ls-files', '-z', cwd=root).split('\0') if name]
    if (platform not in ('ios', 'android') or os.environ.get('GITHUB_REPOSITORY') != repository or
            os.environ.get('GITHUB_REF') != 'refs/heads/master' or
            release['version'] != f'1.{release["build_number"]}' or
            type(release['build_number']) is not int or release['build_number'] < 1 or
            not re.fullmatch(r'[0-9a-f]{40}', release['revision']) or
            release['payload_sha256'] != checksum(root, files)):
        raise ValueError('SDK checkout does not match its recorded release')
    uuid.UUID(release['circle_pipeline_id'])
    head = run('git', 'rev-parse', 'HEAD', cwd=root)
    if os.environ.get('GITHUB_SHA') != head:
        raise ValueError('SDK checkout differs from the workflow commit')
    query = urllib.parse.urlencode({'state': 'closed', 'head': 'CrowdPlay-Inc:release/' + release['version'], 'base': 'master'})
    pulls = github(repository, 'pulls?' + query)
    if len(pulls) != 1:
        raise ValueError('Missing merged SDK release PR')
    pull = github(repository, f'pulls/{pulls[0]["number"]}')
    if (not pull['merged'] or pull['merge_commit_sha'] != head or
            pull['head']['repo']['full_name'] != repository or pull['base']['repo']['full_name'] != repository or
            pull['head']['ref'] != 'release/' + release['version'] or pull['base']['ref'] != 'master'):
        raise ValueError('SDK publication requires its own merged release PR')
    for tag in run('git', 'tag', '--list', '1.*', cwd=root).splitlines():
        match = re.fullmatch(r'1\.(\d+)', tag)
        if match and int(match[1]) > release['build_number']:
            raise ValueError('A newer SDK version was already published')
    return release


def restore_maven(release, destination):
    repository = 'CrowdPlay-Inc/crowdplay_android_sdk'
    archive_path = destination / 'prebuilt-maven.tar.gz'
    gh('release', 'download', 'build/' + release['version'], '--repo', repository,
       '--pattern', archive_path.name, '--output', str(archive_path))
    with archive_path.open('rb') as stream:
        if hashlib.file_digest(stream, 'sha256').hexdigest() != release['maven_archive_sha256']:
            raise ValueError('Prebuilt Maven archive checksum differs')
    with tarfile.open(archive_path, 'r:gz') as archive:
        for member in archive.getmembers():
            if member.name != 'android-maven' and not member.name.startswith('android-maven/'):
                raise ValueError('Unexpected file in prebuilt Maven archive')
        archive.extractall(destination, filter='data')
    maven = destination / 'android-maven'
    if checksum(maven) != release['maven_sha256']:
        raise ValueError('Prebuilt Maven payload checksum differs')
    return maven


def publish(release, root, maven=None):
    repository = f'CrowdPlay-Inc/crowdplay_{release["platform"]}_sdk'
    version = release['version']
    head = run('git', 'rev-parse', 'HEAD', cwd=root)
    tagged = run('git', 'tag', '--list', version, cwd=root)
    if tagged:
        if run('git', 'rev-parse', version + '^{commit}', cwd=root) != head:
            raise ValueError('SDK tag already identifies another commit')
    else:
        if release['platform'] == 'android':
            if maven is None or checksum(maven) != release['maven_sha256']:
                raise ValueError('Missing checked Maven inputs')
            deployed = 0
            for pom in sorted(maven.rglob('*.pom')):
                aar = pom.with_suffix('.aar')
                if aar.is_file():
                    # Keep Maven output visible without logging credential-bearing arguments.
                    subprocess.run(['mvn', 'deploy:deploy-file', '-DpomFile=' + str(pom), '-Dfile=' + str(aar),
                                    '-DrepositoryId=github', '-Durl=https://maven.pkg.github.com/crowdplay-inc/crowdplay_android_sdk',
                                    '-Dpackaging=aar', '-DgeneratePom=false', '-DretryFailedDeploymentCount=3'], check=True)
                    deployed += 1
            if not deployed:
                raise ValueError('No paired Android AAR/POM files to publish')
        tag = github(repository, 'git/tags', {'tag': version, 'object': head, 'type': 'commit',
                     'message': f'SDK {version} from monorepo {release["revision"]}'})
        github(repository, 'git/refs', {'ref': 'refs/tags/' + version, 'sha': tag['sha']})
    try:
        existing = github(repository, 'releases/tags/' + version)
    except RuntimeError as error:
        if '(HTTP 404)' not in str(error):
            raise
        existing = None
    if existing:
        if existing['draft'] or existing['prerelease']:
            raise ValueError('SDK release is incomplete')
    else:
        github(repository, 'releases', {'tag_name': version, 'name': version, 'draft': False,
               'prerelease': False, 'body': 'SDK published from monorepo ' + release['revision']})
    print('Published SDK ' + version)


def circle(path, method='GET'):
    token = os.environ.get('CIRCLE_TOKEN')
    if not token:
        raise ValueError('Missing CIRCLE_TOKEN to resume the private example deployment')
    request = urllib.request.Request('https://circleci.com/api/v2/' + path,
        method=method, headers={'Circle-Token': token, 'Accept': 'application/json'})
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            return json.load(response)
    except urllib.error.HTTPError as error:
        raise RuntimeError(f'CircleCI request failed: HTTP {error.code}') from error


def circle_items(path):
    items, page = [], None
    while True:
        response = circle(path + ('?page-token=' + urllib.parse.quote(page, safe='') if page else ''))
        items.extend(response['items'])
        page = response.get('next_page_token')
        if not page:
            return items


def approve_example(release):
    pipeline_id = str(uuid.UUID(release['circle_pipeline_id']))
    pipeline = circle('pipeline/' + pipeline_id)
    if (pipeline['project_slug'] != 'gh/' + MONOREPO or pipeline['vcs']['revision'] != release['revision'] or
            pipeline['vcs'].get('tag') != 'mobile/sdk/v' + release['version']):
        raise ValueError('CircleCI callback does not identify the original SDK source')
    name = 'mobile-' + release['platform'] + '-sdk-approved'
    # Include reruns of the same pipeline, which have new workflow IDs.
    workflows = circle_items('pipeline/' + pipeline_id + '/workflow')
    for workflow in sorted(workflows, key=lambda item: item.get('created_at', ''), reverse=True):
        if workflow['name'] != 'mobile-sdk':
            continue
        for job in circle_items('workflow/' + workflow['id'] + '/job'):
            if job['name'] != name or job['type'] != 'approval':
                continue
            if job['status'] == 'on_hold':
                circle(f'workflow/{workflow["id"]}/approve/{job["approval_request_id"]}', method='POST')
                print('Resumed the private ' + release['platform'] + ' example deployment')
                return
            elif job['status'] == 'success':
                print('Private example deployment already approved')
                return
    raise ValueError('No active example approval job; rerun the original CircleCI workflow')


if __name__ == '__main__':
    try:
        release = metadata()
        command = sys.argv[1]
        if command == 'inputs':
            destination = Path(os.environ['RUNNER_TEMP'])
            restore_maven(release, destination)
        elif command == 'publish':
            maven = Path(os.environ['RUNNER_TEMP']) / 'android-maven'
            publish(release, Path('.'), maven if release['platform'] == 'android' else None)
        elif command == 'approve-example':
            approve_example(release)
        else:
            raise ValueError('Usage: sdk_release.py inputs|publish|approve-example')
    except (OSError, ValueError, KeyError, RuntimeError, tarfile.TarError, subprocess.CalledProcessError) as error:
        sys.exit(str(error))
