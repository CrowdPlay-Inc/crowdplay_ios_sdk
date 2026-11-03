// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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


// flutter_wallet_card-9149cd260c2f0ad648d789d46f6f8aa45d1ad1e3