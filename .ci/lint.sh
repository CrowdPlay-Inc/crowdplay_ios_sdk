#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

version=0.65.1
tool_dir="${SDK_CI_TOOLS_DIR:-${RUNNER_TEMP:-${TMPDIR:-/tmp}}/crowdplay-ios-ci}/swiftlint-$version"
mkdir -p "$tool_dir"
if [[ ! -f "$tool_dir/portable_swiftlint.zip" ]]; then
  curl --fail --location --silent --show-error --retry 3 \
    "https://github.com/realm/SwiftLint/releases/download/$version/portable_swiftlint.zip" \
    --output "$tool_dir/portable_swiftlint.zip"
fi
echo "c1e429b0599cf1b516f369a2d9ec04eaf0e436f3c12b637df8851fa52ff694d0  $tool_dir/portable_swiftlint.zip" | shasum -a 256 --check
unzip -oq "$tool_dir/portable_swiftlint.zip" -d "$tool_dir"
"$tool_dir/swiftlint" lint --strict --no-cache --config .swiftlint.yml
