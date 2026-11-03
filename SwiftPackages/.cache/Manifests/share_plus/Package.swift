// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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


// share_plus-10.1.3