// swift-tools-version: 5.9
// Export template. package_ios_sdk.py embeds the generated Flutter manifests.

import Foundation
import PackageDescription

struct EmbeddedPackage {
    let path: String
    let package: Package
}

func embeddedPackage0() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//


// Release

let package = Package(
    name: "FlutterPluginRegistrant",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "FlutterPluginRegistrant", type: .static, targets: ["FlutterPluginRegistrant"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "Packages/FlutterFramework"),
        .package(name: "app_links", path: "Packages/app_links"),
        .package(name: "audioplayers_darwin", path: "Packages/audioplayers_darwin"),
        .package(name: "device_info_plus", path: "Packages/device_info_plus"),
        .package(name: "firebase_auth", path: "Packages/firebase_auth"),
        .package(name: "firebase_core", path: "Packages/firebase_core"),
        .package(name: "firebase_database", path: "Packages/firebase_database"),
        .package(name: "firebase_messaging", path: "Packages/firebase_messaging"),
        .package(name: "flutter_local_notifications", path: "Packages/flutter_local_notifications"),
        .package(name: "flutter_secure_storage_darwin", path: "Packages/flutter_secure_storage_darwin"),
        .package(name: "flutter_wallet_card", path: "Packages/flutter_wallet_card"),
        .package(name: "image_picker_ios", path: "Packages/image_picker_ios"),
        .package(name: "location", path: "Packages/location"),
        .package(name: "mobile_scanner", path: "Packages/mobile_scanner"),
        .package(name: "package_info_plus", path: "Packages/package_info_plus"),
        .package(name: "path_provider_foundation", path: "Packages/path_provider_foundation"),
        .package(name: "rtl_sdk", path: "Packages/rtl_sdk"),
        .package(name: "sentry_flutter", path: "Packages/sentry_flutter"),
        .package(name: "share_plus", path: "Packages/share_plus"),
        .package(name: "shared_preferences_foundation", path: "Packages/shared_preferences_foundation"),
        .package(name: "sqflite_darwin", path: "Packages/sqflite_darwin"),
        .package(name: "url_launcher_ios", path: "Packages/url_launcher_ios"),
        .package(name: "vibration", path: "Packages/vibration"),
        .package(name: "webview_flutter_wkwebview", path: "Packages/webview_flutter_wkwebview")
    ],
    targets: [
        .target(
            name: "FlutterPluginRegistrant",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "app-links", package: "app_links"),
                .product(name: "audioplayers-darwin", package: "audioplayers_darwin"),
                .product(name: "device-info-plus", package: "device_info_plus"),
                .product(name: "firebase-auth", package: "firebase_auth"),
                .product(name: "firebase-core", package: "firebase_core"),
                .product(name: "firebase-database", package: "firebase_database"),
                .product(name: "firebase-messaging", package: "firebase_messaging"),
                .product(name: "flutter-local-notifications", package: "flutter_local_notifications"),
                .product(name: "flutter-secure-storage-darwin", package: "flutter_secure_storage_darwin"),
                .product(name: "flutter-wallet-card", package: "flutter_wallet_card"),
                .product(name: "image-picker-ios", package: "image_picker_ios"),
                .product(name: "location", package: "location"),
                .product(name: "mobile-scanner", package: "mobile_scanner"),
                .product(name: "package-info-plus", package: "package_info_plus"),
                .product(name: "path-provider-foundation", package: "path_provider_foundation"),
                .product(name: "rtl-sdk", package: "rtl_sdk"),
                .product(name: "sentry-flutter", package: "sentry_flutter"),
                .product(name: "share-plus", package: "share_plus"),
                .product(name: "shared-preferences-foundation", package: "shared_preferences_foundation"),
                .product(name: "sqflite-darwin", package: "sqflite_darwin"),
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "vibration", package: "vibration"),
                .product(name: "webview-flutter-wkwebview", package: "webview_flutter_wkwebview"),
                .target(name: "App")
            ]
        ),
        .binaryTarget(
            name: "App",
            path: "Frameworks/App.xcframework"
        )
    ]
)

return package
}

func embeddedPackage1() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//


let package = Package(
    name: "FlutterFramework",
    products: [
        .library(name: "FlutterFramework", targets: ["FlutterFramework"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "FlutterFramework",
            dependencies: [
                .target(name: "Flutter")
            ]
        ),
        .binaryTarget(
            name: "Flutter",
            path: "../../Frameworks/Flutter.xcframework"
        )
    ]
)

return package
}

func embeddedPackage2() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "app_links",
    platforms: [
       .iOS("12.0")
    ],
    products: [
        // library and target names.
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "app-links", targets: ["app_links"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "app_links",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
return package
}

func embeddedPackage3() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
  name: "audioplayers_darwin",
  platforms: [
    .iOS("12.0"),
    .macOS("10.14"),
  ],
  products: [
    .library(name: "audioplayers-darwin", targets: ["audioplayers_darwin"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "audioplayers_darwin",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        // TODO: If your plugin requires a privacy manifest
        // (e.g. if it uses any required reason APIs), update the PrivacyInfo.xcprivacy file
        // to describe your plugin's privacy impact, and then uncomment this line.
        // For more information, see:
        // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
        // .process("PrivacyInfo.xcprivacy"),

        // TODO: If you have other resources that need to be bundled with your plugin, refer to
        // the following instructions to add them:
        // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
      ]
    )
  ]
)

return package
}

func embeddedPackage4() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "device_info_plus",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "device-info-plus", targets: ["device_info_plus"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "device_info_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .headerSearchPath("include/device_info_plus")
            ]
        )
    ]
)

return package
}

func embeddedPackage5() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


let libraryVersion = "7.0.1"
let firebaseSdkVersion: Version = "13.1.1"

let package = Package(
  name: "firebase_auth",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(name: "firebase-auth", targets: ["firebase_auth"])
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", "12.19.3"..."13.1.1"),
    .package(name: "firebase_core", path: "../firebase_core"),
    .package(name: "FlutterFramework", path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "firebase_auth",
      dependencies: [
        .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
        .product(name: "firebase-core", package: "firebase_core"),
        .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ],
      cSettings: [
        .define("LIBRARY_VERSION", to: "\"\(libraryVersion)\""),
        .define("LIBRARY_NAME", to: "\"flutter-fire-auth\""),
      ]
    )
  ]
)

return package
}

func embeddedPackage6() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


let libraryVersionString = "5.1.0"
let firebaseSdkVersion: Version = "13.1.1"

let package = Package(
  name: "firebase_core",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(name: "firebase-core", targets: ["firebase_core", "firebase_core_objc"])
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", "12.19.3"..."13.1.1"),
    .package(name: "FlutterFramework", path: "../FlutterFramework"),
  ],
  targets: [
    // SPM does not allow mixing Swift and ObjC in a single target.
    // The ObjC target keeps FLTFirebasePlugin / Registry as the public
    // header surface other plugins `#import <firebase_core/...>`.
    .target(
      name: "firebase_core_objc",
      dependencies: [
        .product(name: "FirebaseInstallations", package: "firebase-ios-sdk"),
        .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      path: "Sources/firebase_core_objc",
      publicHeadersPath: "include",
      cSettings: [
        .headerSearchPath("include/firebase_core"),
        .headerSearchPath("include"),
        .define("LIBRARY_VERSION", to: "\"\(libraryVersionString)\""),
        .define("LIBRARY_NAME", to: "\"flutter-fire-core\""),
      ]
    ),
    .target(
      name: "firebase_core",
      dependencies: [
        "firebase_core_objc",
        .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
        .product(name: "FirebaseInstallations", package: "firebase-ios-sdk"),
        .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      path: "Sources/firebase_core",
      resources: [
        .process("Resources")
      ]
    ),
  ]
)

return package
}

func embeddedPackage7() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


let libraryVersion = "13.0.1"
let firebaseSdkVersion: Version = "13.1.1"

let package = Package(
  name: "firebase_database",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(name: "firebase-database", targets: ["firebase_database"])
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", "12.19.3"..."13.1.1"),
    .package(name: "firebase_core", path: "../firebase_core"),
    .package(name: "FlutterFramework", path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "firebase_database",
      dependencies: [
        .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
        .product(name: "firebase-core", package: "firebase_core"),
        .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ],
      cSettings: [
        .headerSearchPath("include"),
        .define("LIBRARY_VERSION", to: "\"\(libraryVersion)\""),
        .define("LIBRARY_NAME", to: "\"flutter-fire-rtdb\""),
      ]
    )
  ]
)

return package
}

func embeddedPackage8() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


let libraryVersion = "17.0.1"
let firebaseSdkVersion: Version = "13.1.1"

let package = Package(
  name: "firebase_messaging",
  platforms: [
    .iOS("15.0")
  ],
  products: [
    .library(name: "firebase-messaging", targets: ["firebase_messaging"])
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", "12.19.3"..."13.1.1"),
    .package(name: "firebase_core", path: "../firebase_core"),
    .package(name: "FlutterFramework", path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "firebase_messaging",
      dependencies: [
        .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
        .product(name: "firebase-core", package: "firebase_core"),
        .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ],
      cSettings: [
        .headerSearchPath("include"),
        .define("LIBRARY_VERSION", to: "\"\(libraryVersion)\""),
        .define("LIBRARY_NAME", to: "\"flutter-fire-fcm\""),
      ]
    )
  ]
)

return package
}

func embeddedPackage9() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "flutter_local_notifications",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-local-notifications", targets: ["flutter_local_notifications"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_local_notifications",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ],
            cSettings: [
                .headerSearchPath("include/flutter_local_notifications")
            ]
        )
    ]
)

return package
}

func embeddedPackage10() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "flutter_secure_storage_darwin",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(name: "flutter-secure-storage-darwin", targets: ["flutter_secure_storage_darwin"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "flutter_secure_storage_darwin",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("Resources"),
            ]
        )
    ]
)

return package
}

func embeddedPackage11() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "flutter_wallet_card",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-wallet-card", targets: ["flutter_wallet_card"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "flutter_wallet_card",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: []
        )
    ]
)

return package
}

func embeddedPackage12() -> Package {
// swift-tools-version: 5.9

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


let package = Package(
  name: "image_picker_ios",
  platforms: [
    .iOS("12.0")
  ],
  products: [
    .library(name: "image-picker-ios", targets: ["image_picker_ios"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "image_picker_ios",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      exclude: ["include/image_picker_ios-umbrella.h", "include/ImagePickerPlugin.modulemap"],
      resources: [
        .process("Resources")
      ],
      cSettings: [
        .headerSearchPath("include/image_picker_ios")
      ]
    )
  ]
)

return package
}

func embeddedPackage13() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to
// build this package.


let package = Package(
    name: "location",
    platforms: [
        .iOS("12.0"),
        .macOS("10.15"),
    ],
    products: [
        .library(name: "location", targets: ["location"]),
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "location",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ]
        ),
    ]
)

return package
}

func embeddedPackage14() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "mobile_scanner",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(name: "mobile-scanner", targets: ["mobile_scanner"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "mobile_scanner",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("Resources"),
            ]
        )
    ]
)

return package
}

func embeddedPackage15() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "package_info_plus",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "package-info-plus", targets: ["package_info_plus"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "package_info_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .headerSearchPath("include/package_info_plus")
            ]
        )
    ]
)

return package
}

func embeddedPackage16() -> Package {
// swift-tools-version: 5.9

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


let package = Package(
  name: "path_provider_foundation",
  platforms: [
    .iOS("12.0"),
    .macOS("10.14"),
  ],
  products: [
    .library(name: "path-provider-foundation", targets: ["path_provider_foundation"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "path_provider_foundation",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ]
    )
  ]
)

return package
}

func embeddedPackage17() -> Package {
// swift-tools-version: 5.9


// Only development/CI overrides this dependency; exported consumers use the exact tag.
let nativeDependency: Package.Dependency = ProcessInfo.processInfo.environment["RTL_IOS_SDK_PATH"]
    .flatMap { $0.isEmpty ? nil : .package(name: "rtl_ios_sdk", path: $0) }
    ?? .package(url: "https://github.com/BOON-Rewards/rtl_ios_sdk.git", exact: "4.3.0")

let package = Package(
    name: "rtl_sdk",
    platforms: [.iOS("15.0")],
    products: [.library(name: "rtl-sdk", targets: ["rtl_sdk"])],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        nativeDependency
    ],
    targets: [
        .target(name: "rtl_sdk", dependencies: [
            .product(name: "FlutterFramework", package: "FlutterFramework"),
            .product(name: "RTLSdk", package: "rtl_ios_sdk")
        ])
    ]
)

return package
}

func embeddedPackage18() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "sentry_flutter",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        .library(name: "sentry-flutter", targets: ["sentry_flutter", "sentry_flutter_objc"])
    ],
    dependencies: [
      .package(url: "https://github.com/getsentry/sentry-cocoa", exact: "8.58.4"),
      .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "sentry_flutter",
            dependencies: [
                "sentry_flutter_objc",
                .product(name: "Sentry", package: "sentry-cocoa"),
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            swiftSettings: [
                .define("SENTRY_FLUTTER_SPM")
            ]
        ),
        // SPM does not support mixed-language targets, so we need to move the ObjC files into a separate one
        .target(
            name: "sentry_flutter_objc",
            dependencies: [
                .product(name: "Sentry", package: "sentry-cocoa"),
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ]
        )
    ]
)

return package
}

func embeddedPackage19() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "share_plus",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "share-plus", targets: ["share_plus"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "share_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .headerSearchPath("include/share_plus")
            ]
        )
    ]
)

return package
}

func embeddedPackage20() -> Package {
// swift-tools-version: 5.9

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


let package = Package(
  name: "shared_preferences_foundation",
  platforms: [
    .iOS("12.0"),
    .macOS("10.14"),
  ],
  products: [
    .library(name: "shared-preferences-foundation", targets: ["shared_preferences_foundation"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "shared_preferences_foundation",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ]
    )
  ]
)

return package
}

func embeddedPackage21() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "sqflite_darwin",
    platforms: [
        .iOS("12.0"),
        .macOS("10.14")
    ],
    products: [
        // TODO: Update your library and target names.
        // If the plugin name contains "_", replace with "-" for the library name
        .library(name: "sqflite-darwin", targets: ["sqflite_darwin"])
    ],
    dependencies: [
        .package(path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "sqflite_darwin",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            resources: [
                .process("Resources"),

                // TODO: If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ],
            cSettings: [
                .headerSearchPath("include/sqflite_darwin")
            ]
        )
    ]
)
return package
}

func embeddedPackage22() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


let package = Package(
  name: "url_launcher_ios",
  platforms: [
    .iOS("12.0")
  ],
  products: [
    .library(name: "url-launcher-ios", targets: ["url_launcher_ios"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "url_launcher_ios",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ]
    )
  ]
)

return package
}

func embeddedPackage23() -> Package {
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


let package = Package(
    name: "vibration",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "vibration", targets: ["vibration"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "vibration",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)

return package
}

func embeddedPackage24() -> Package {
// swift-tools-version: 5.9

// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


let package = Package(
  name: "webview_flutter_wkwebview",
  platforms: [
    .iOS("13.0"),
    .macOS("10.15"),
  ],
  products: [
    .library(name: "webview-flutter-wkwebview", targets: ["webview_flutter_wkwebview"])
  ],
  dependencies: [
      .package(path: "../FlutterFramework"),
  ],
  targets: [
    .target(
      name: "webview_flutter_wkwebview",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework"),
      ],
      resources: [
        .process("Resources")
      ]
    )
  ]
)

return package
}


let embeddedPackages: [EmbeddedPackage] = [
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release", package: embeddedPackage0()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/FlutterFramework", package: embeddedPackage1()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/app_links", package: embeddedPackage2()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/audioplayers_darwin", package: embeddedPackage3()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/device_info_plus", package: embeddedPackage4()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/firebase_auth", package: embeddedPackage5()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/firebase_core", package: embeddedPackage6()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/firebase_database", package: embeddedPackage7()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/firebase_messaging", package: embeddedPackage8()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/flutter_local_notifications", package: embeddedPackage9()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/flutter_secure_storage_darwin", package: embeddedPackage10()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/flutter_wallet_card", package: embeddedPackage11()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/image_picker_ios", package: embeddedPackage12()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/location", package: embeddedPackage13()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/mobile_scanner", package: embeddedPackage14()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/package_info_plus", package: embeddedPackage15()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/path_provider_foundation", package: embeddedPackage16()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/rtl_sdk", package: embeddedPackage17()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/sentry_flutter", package: embeddedPackage18()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/share_plus", package: embeddedPackage19()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/shared_preferences_foundation", package: embeddedPackage20()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/sqflite_darwin", package: embeddedPackage21()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/url_launcher_ios", package: embeddedPackage22()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/vibration", package: embeddedPackage23()),
    EmbeddedPackage(path: "SwiftPackages/FlutterNativeIntegration/Release/Packages/webview_flutter_wkwebview", package: embeddedPackage24()),
]

let package = Package(
    name: "crowdplaysdk",
    platforms: [.iOS("16.0")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "crowdplaysdk",
            targets: ["crowdplaysdk"])
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", "12.19.3"..."13.1.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "crowdplaysdk",
            dependencies: [
                .target(name: "FlutterPluginRegistrant"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
            ],
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]),
        .testTarget(
            name: "crowdplay_ios_sdkTests",
            dependencies: ["crowdplaysdk"]),
    ]
)

// Keep upstream Target objects so resources, headers and compiler/linker settings
// survive unchanged. Only their paths and local product dependencies are adapted.
func flattenPackages(into root: Package, embedded: [EmbeddedPackage]) {
    let packages = [EmbeddedPackage(path: ".", package: root)] + embedded
    var byPath: [String: Package] = [:]
    for item in packages { byPath[item.path] = item.package }

    func joined(_ base: String, _ path: String) -> String {
        precondition(!path.hasPrefix("/"), "Expected a relative export path: \(path)")
        // Normalize lexically: resolving Flutter's plugin symlinks here would
        // make ../FlutterFramework point outside the logical Packages directory.
        var parts: [String] = []
        for part in (base + "/" + path).split(separator: "/") {
            if part == "." { continue }
            if part == ".." {
                precondition(!parts.isEmpty, "Export path escapes package: \(path)")
                parts.removeLast()
            } else {
                parts.append(String(part))
            }
        }
        return parts.joined(separator: "/")
    }
    func identity(_ location: String) -> String {
        let name = (location as NSString).lastPathComponent.lowercased()
        return name.hasSuffix(".git") ? String(name.dropLast(4)) : name
    }
    func repositoryLocation(_ location: String) -> String {
        var normalized = location
        while normalized.hasSuffix("/") { normalized.removeLast() }
        if normalized.hasSuffix(".git") { normalized.removeLast(4) }
        return normalized
    }

    var remoteDependencies: [Package.Dependency] = []
    var remoteNames: [String: String] = [:]
    var remoteLocations: [String: String] = [:]
    var remoteRequirements: [String: String] = [:]
    var targets: [Target] = []
    var targetNames = Set<String>()

    for item in packages {
        let current = item.package
        if item.path != "." {
            precondition(current.defaultLocalization == nil &&
                         current.swiftLanguageVersions == nil &&
                         current.cLanguageStandard == nil &&
                         current.cxxLanguageStandard == nil,
                         "Review package-level language/localization settings for \(current.name)")
        }
        var localProducts: [String: [String: [String]]] = [:]
        var externalAliases: [String: String] = [:]
        for dependency in current.dependencies {
            switch dependency.kind {
            case let .fileSystem(name, path):
                guard let local = byPath[joined(item.path, path)] else {
                    preconditionFailure("Unpackaged local dependency: \(current.name)/\(path)")
                }
                var products: [String: [String]] = [:]
                for product in local.products {
                    guard let library = product as? Product.Library else {
                        preconditionFailure("Expected library product: \(product.name)")
                    }
                    products[library.name] = library.targets
                }
                localProducts[(name ?? identity(path)).lowercased()] = products
            case let .sourceControl(name, location, requirement):
                let key = identity(location)
                let signature = String(describing: requirement)
                if let previous = remoteRequirements[key] {
                    precondition(remoteLocations[key] == repositoryLocation(location),
                                 "Different repository URLs share package identity \(key); review \(current.name)")
                    precondition(previous == signature, "Conflicting requirements for \(key)")
                } else {
                    remoteRequirements[key] = signature
                    remoteNames[key] = name ?? key
                    remoteLocations[key] = repositoryLocation(location)
                    remoteDependencies.append(dependency)
                }
                externalAliases[(name ?? key).lowercased()] = remoteNames[key]
            case .registry:
                preconditionFailure("Review registry dependency in \(current.name)")
            @unknown default:
                preconditionFailure("Review dependency kind in \(current.name)")
            }
        }

        for target in current.targets {
            if item.path != "." && target.isTest { continue }
            precondition(targetNames.insert(target.name).inserted,
                         "Duplicate embedded target: \(target.name)")
            var dependencies: [Target.Dependency] = []
            for dependency in target.dependencies {
                switch dependency {
                case let .productItem(name, package, aliases, condition):
                    let key = package?.lowercased() ?? ""
                    if let products = localProducts[key] {
                        precondition(aliases == nil, "Review local module aliases for \(name)")
                        guard let names = products[name] else {
                            preconditionFailure("Missing local product: \(name)")
                        }
                        for name in names {
                            dependencies.append(.target(name: name, condition: condition))
                        }
                    } else {
                        dependencies.append(.productItem(name: name,
                            package: externalAliases[key] ?? package,
                            moduleAliases: aliases, condition: condition))
                    }
                case .targetItem, .byNameItem:
                    dependencies.append(dependency)
                @unknown default:
                    preconditionFailure("Review dependency in target \(target.name)")
                }
            }
            target.dependencies = dependencies
            if target.type == .binary {
                if let path = target.path { target.path = joined(item.path, path) }
            } else {
                let path = target.path ?? "\(target.isTest ? "Tests" : "Sources")/\(target.name)"
                target.path = joined(item.path, path)
            }
            targets.append(target)
        }
    }
    root.dependencies = remoteDependencies
    root.targets = targets
}

flattenPackages(into: package, embedded: embeddedPackages)
