// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Local",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Local",
            targets: ["Local"]
        ),
    ],
    dependencies: [
        .package(path: "./Util")
    ],
    targets: [
        .target(
            name: "Local",
            dependencies: [
                .product(name: "Util", package: "Util")
            ]
        ),
        .testTarget(
            name: "LocalTests",
            dependencies: ["Local"]
        ),
    ]
)
