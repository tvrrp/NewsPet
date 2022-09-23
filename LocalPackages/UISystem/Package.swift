// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UISystem",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UISystem",
            targets: ["UISystem"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UISystem",
            dependencies: []
        )
    ]
)
