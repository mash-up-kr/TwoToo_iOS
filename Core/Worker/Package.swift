// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Worker",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Worker",
            targets: ["Worker"]
        ),
    ],
    dependencies: [
        .package(path: "./Network"),
        .package(path: "./Local"),
        .package(path: "./DesignSystem")
    ],
    targets: [
        .target(
            name: "Worker",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Local", package: "Local"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "WorkerTests",
            dependencies: ["Worker"]
        ),
    ]
)
