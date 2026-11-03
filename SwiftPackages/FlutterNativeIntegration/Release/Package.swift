// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

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
