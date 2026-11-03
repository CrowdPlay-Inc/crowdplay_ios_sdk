// swift-tools-version: 5.9

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import PackageDescription

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


// path_provider_foundation-2.4.0