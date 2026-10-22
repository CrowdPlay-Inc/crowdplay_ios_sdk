# CrowdPlay iOS SDK

This repository owns the native Swift wrapper and SPM-based `Example` host. CrowdPlay's
Flutter SDK export scripts populate the generated package and `SwiftPackages`
directory for release. Native source changes alone do not regenerate those artifacts.

## Installation

Add a generated SDK release through its Git URL in Xcode and select the
`crowdplaysdk` product. A complete local checkout can also be added as a package.
Use iOS 16 or later and Xcode 26.2 or later with the Firebase 13 exports. Resolve
the host's Firebase dependencies and the SDK's dependencies as one compatible graph.

Set `FLUTTER_SWIFT_PACKAGE_OUTPUT` to the SDK checkout's `SwiftPackages` directory
and `FLUTTER_BUILD_MODE=release`. Resolve packages before invoking the scripts.

1. Add a scheme build pre-action, using the host target's build settings:
   `/bin/sh "$FLUTTER_SWIFT_PACKAGE_OUTPUT/Scripts/flutter_integration.sh" prebuild`.
2. Add a build phase:
   `/bin/sh "$FLUTTER_SWIFT_PACKAGE_OUTPUT/Scripts/flutter_integration.sh" assemble`.
   Disable dependency analysis and use input file list
   `$(FLUTTER_SWIFT_PACKAGE_OUTPUT)/Scripts/FlutterAssembleInputs.xcfilelist`.
3. Preserve the host's URL scheme and forward supported app links to
   `CrowdplaySdk.shared.handleAppLink(appLink:vc:)` as demonstrated by the example app.

Hosts consuming the precompiled Dart artifacts do not need Flutter installed.
Xcode compiles the native source packages and resources.

## Example and release automation

Open `Example/crowdplaysdk.xcodeproj` after generating the complete SDK export.
The example consumes the root package and configures Flutter's integration scripts.

The example retains its SSO, logout, points and loyalty QR-code demonstrations.
Its original callback scheme, `cpsdkdemopod`, and notification-permission behavior
are preserved.

`Example` contains its own Gemfile, lockfile and Fastlane configuration. For a
signed example archive, run `bundle install` and `bundle exec fastlane build` from
that directory with the required signing credentials configured. Keep
`Example/gc_keys.json` private; it is ignored by Git.

## Author

Matthew Baker, matt@bakermatt.com

## License

crowdplaysdk is available under the MIT license. See [LICENSE.md](LICENSE.md).
