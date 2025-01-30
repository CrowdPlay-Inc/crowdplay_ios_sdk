// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.4.0"),
        .package(url: "https://github.com/google/GoogleUtilities.git", from: "8.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "crowdplaysdk",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                "App", "Braintree", "BraintreeDropIn", "CocoaAsyncSocket", "Cryptor",
                "CryptorECC", "CryptorRSA", "Flutter", "FlutterPluginRegistrant",
                "GTMSessionFetcher", "KituraContracts", "LoggerAPI", "LoggingFramework",
                "OrderedSet",
                "Sentry", "SwiftJWT", "audioplayers_darwin", "device_info_plus", "firebase_auth",
                "firebase_core", "firebase_database", "firebase_messaging", "firebase_storage",
                "flutter_inappwebview_ios", "flutter_local_notifications", "image_picker_ios",
                "integration_test", "location", "package_info_plus",
                "path_provider_foundation", "patrol", "sentry_flutter",
                "share_plus", "shift4_sdk", "store_redirect", "app_links", "url_launcher_ios",
                "vibration", "CardinalMobile", "PPRiskMagnes", "VNWebSDK", "mobile_scanner"
            ],
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]),
        .binaryTarget(
            name: "App",
            path: "Frameworks/App.xcframework"
        ),
        .binaryTarget(
            name: "Braintree",
            path: "Frameworks/Braintree.xcframework"
        ),
        .binaryTarget(
            name: "BraintreeDropIn",
            path: "Frameworks/BraintreeDropIn.xcframework"
        ),
        .binaryTarget(
            name: "CocoaAsyncSocket",
            path: "Frameworks/CocoaAsyncSocket.xcframework"
        ),
        .binaryTarget(
            name: "Cryptor",
            path: "Frameworks/Cryptor.xcframework"
        ),
        .binaryTarget(
            name: "CryptorECC",
            path: "Frameworks/CryptorECC.xcframework"
        ),
        .binaryTarget(
            name: "CryptorRSA",
            path: "Frameworks/CryptorRSA.xcframework"
        ),
        .binaryTarget(
            name: "Flutter",
            path: "Frameworks/Flutter.xcframework"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            path: "Frameworks/FlutterPluginRegistrant.xcframework"
        ),
        .binaryTarget(
            name: "GTMSessionFetcher",
            path: "Frameworks/GTMSessionFetcher.xcframework"
        ),
        .binaryTarget(
            name: "KituraContracts",
            path: "Frameworks/KituraContracts.xcframework"
        ),
        .binaryTarget(
            name: "LoggerAPI",
            path: "Frameworks/LoggerAPI.xcframework"
        ),
        .binaryTarget(
            name: "LoggingFramework",
            path: "Frameworks/Logging.xcframework"
        ),
        .binaryTarget(
            name: "OrderedSet",
            path: "Frameworks/OrderedSet.xcframework"
        ),
        .binaryTarget(
            name: "Sentry",
            path: "Frameworks/Sentry.xcframework"
        ),
        .binaryTarget(
            name: "SwiftJWT",
            path: "Frameworks/SwiftJWT.xcframework"
        ),
        .binaryTarget(
            name: "audioplayers_darwin",
            path: "Frameworks/audioplayers_darwin.xcframework"
        ),
        .binaryTarget(
            name: "device_info_plus",
            path: "Frameworks/device_info_plus.xcframework"
        ),
        .binaryTarget(
            name: "firebase_auth",
            path: "Frameworks/firebase_auth.xcframework"
        ),
        .binaryTarget(
            name: "firebase_core",
            path: "Frameworks/firebase_core.xcframework"
        ),
        .binaryTarget(
            name: "firebase_database",
            path: "Frameworks/firebase_database.xcframework"
        ),
        .binaryTarget(
            name: "firebase_messaging",
            path: "Frameworks/firebase_messaging.xcframework"
        ),
        .binaryTarget(
            name: "firebase_storage",
            path: "Frameworks/firebase_storage.xcframework"
        ),
        .binaryTarget(
            name: "flutter_inappwebview_ios",
            path: "Frameworks/flutter_inappwebview_ios.xcframework"
        ),
        .binaryTarget(
            name: "flutter_local_notifications",
            path: "Frameworks/flutter_local_notifications.xcframework"
        ),
        .binaryTarget(
            name: "image_picker_ios",
            path: "Frameworks/image_picker_ios.xcframework"
        ),
        .binaryTarget(
            name: "integration_test",
            path: "Frameworks/integration_test.xcframework"
        ),
        .binaryTarget(
            name: "location",
            path: "Frameworks/location.xcframework"
        ),
        .binaryTarget(
            name: "package_info_plus",
            path: "Frameworks/package_info_plus.xcframework"
        ),
        .binaryTarget(
            name: "path_provider_foundation",
            path: "Frameworks/path_provider_foundation.xcframework"
        ),
        .binaryTarget(
            name: "patrol",
            path: "Frameworks/patrol.xcframework"
        ),
        .binaryTarget(
            name: "mobile_scanner",
            path: "Frameworks/mobile_scanner.xcframework"
        ),
        .binaryTarget(
            name: "sentry_flutter",
            path: "Frameworks/sentry_flutter.xcframework"
        ),
        .binaryTarget(
            name: "share_plus",
            path: "Frameworks/share_plus.xcframework"
        ),
        .binaryTarget(
            name: "shift4_sdk",
            path: "Frameworks/shift4_sdk.xcframework"
        ),
        .binaryTarget(
            name: "store_redirect",
            path: "Frameworks/store_redirect.xcframework"
        ),
        .binaryTarget(
            name: "app_links",
            path: "Frameworks/app_links.xcframework"
        ),
        .binaryTarget(
            name: "url_launcher_ios",
            path: "Frameworks/url_launcher_ios.xcframework"
        ),
        .binaryTarget(
            name: "vibration",
            path: "Frameworks/vibration.xcframework"
        ),
        .binaryTarget(
            name: "CardinalMobile",
            path: "FixedFrameworks/CardinalMobile.xcframework"
        ),
        .binaryTarget(
            name: "PPRiskMagnes",
            path: "FixedFrameworks/PPRiskMagnes.xcframework"
        ),
        .binaryTarget(
            name: "VNWebSDK",
            path: "FixedFrameworks/VNWebSDK.xcframework"
        ),
        .testTarget(
            name: "crowdplay_ios_sdkTests",
            dependencies: ["crowdplaysdk"]),
    ]
)
