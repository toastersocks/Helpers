// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Helpers",
    platforms: [.iOS(.v13), .macOS(.v11), .watchOS(.v8)],
    products: [
        .library(
            name: "Helpers",
            targets: ["Helpers"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Helpers",
            dependencies: []),
        .testTarget(
            name: "HelpersTests",
            dependencies: ["Helpers"]),
    ]
)
