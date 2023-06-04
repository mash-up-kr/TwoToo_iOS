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
    ],
    targets: [
        .target(
            name: "Worker",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Local", package: "Local")
            ]
        ),
        .testTarget(
            name: "WorkerTests",
            dependencies: ["Worker"]
        ),
    ]
)
