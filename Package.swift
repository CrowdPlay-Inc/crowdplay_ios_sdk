// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "crowdplaysdk",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "crowdplaysdk",
            targets: ["crowdplaysdk"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.24.0"),
        .package(url: "https://github.com/google/GoogleUtilities.git", from: "7.11.0")
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
                "App", "audioplayers_darwin", "CocoaAsyncSocket", "device_info_plus", "firebase_auth", "firebase_core", "firebase_database", "firebase_messaging", "firebase_storage", "Flutter", "FlutterPluginRegistrant", "flutter_inappwebview", "flutter_local_notifications", "GTMSessionFetcher", "HTTPParserC", "image_picker_ios", "integration_test", "location", "MTBBarcodeScanner", "OrderedSet", "package_info", "path_provider_foundation", "patrol", "qr_code_scanner", "share", "store_redirect", "Telegraph", "uni_links", "url_launcher_ios", "vibration"            ],
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]),
        .binaryTarget(
            name: "App",
            path: "Frameworks/App.xcframework"
        ),
        .binaryTarget(
            name: "audioplayers_darwin",
            path: "Frameworks/audioplayers_darwin.xcframework"
        ),
        .binaryTarget(
            name: "CocoaAsyncSocket",
            path: "Frameworks/CocoaAsyncSocket.xcframework"
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
            name: "Flutter",
            path: "Frameworks/Flutter.xcframework"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            path: "Frameworks/FlutterPluginRegistrant.xcframework"
        ),
        .binaryTarget(
            name: "flutter_inappwebview",
            path: "Frameworks/flutter_inappwebview.xcframework"
        ),
        .binaryTarget(
            name: "flutter_local_notifications",
            path: "Frameworks/flutter_local_notifications.xcframework"
        ),
        .binaryTarget(
            name: "GTMSessionFetcher",
            path: "Frameworks/GTMSessionFetcher.xcframework"
        ),
        .binaryTarget(
            name: "HTTPParserC",
            path: "Frameworks/HTTPParserC.xcframework"
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
            name: "MTBBarcodeScanner",
            path: "Frameworks/MTBBarcodeScanner.xcframework"
        ),
        .binaryTarget(
            name: "OrderedSet",
            path: "Frameworks/OrderedSet.xcframework"
        ),
        .binaryTarget(
            name: "package_info",
            path: "Frameworks/package_info.xcframework"
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
            name: "qr_code_scanner",
            path: "Frameworks/qr_code_scanner.xcframework"
        ),
        .binaryTarget(
            name: "share",
            path: "Frameworks/share.xcframework"
        ),
        .binaryTarget(
            name: "store_redirect",
            path: "Frameworks/store_redirect.xcframework"
        ),
        .binaryTarget(
            name: "Telegraph",
            path: "Frameworks/Telegraph.xcframework"
        ),
        .binaryTarget(
            name: "uni_links",
            path: "Frameworks/uni_links.xcframework"
        ),
        .binaryTarget(
            name: "url_launcher_ios",
            path: "Frameworks/url_launcher_ios.xcframework"
        ),
        .binaryTarget(
            name: "vibration",
            path: "Frameworks/vibration.xcframework"
        ),
        .testTarget(
            name: "crowdplay_ios_sdkTests",
            dependencies: ["crowdplaysdk"]),
    ]
)
