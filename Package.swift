// swift-tools-version: 6.3.3

// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-url-routing-form-coding open source
// project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the
// swift-url-routing-form-coding project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import PackageDescription

let package = Package(
    name: "swift-url-routing-form-coding",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
    ],
    products: [
        // The url-routing × form-coding bridge: application/x-www-form-urlencoded
        // bodies as typed conversions in route definitions.
        .library(
            name: "URL Routing Form Coding",
            targets: ["URL Routing Form Coding"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-url-routing.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-url-form-coding.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "URL Routing Form Coding",
            dependencies: [
                .product(name: "URLRouting", package: "swift-url-routing"),
                .product(name: "URLFormCoding", package: "swift-url-form-coding"),
            ]
        ),
        .testTarget(
            name: "URL Routing Form Coding Tests",
            dependencies: [
                "URL Routing Form Coding"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        ]
}
