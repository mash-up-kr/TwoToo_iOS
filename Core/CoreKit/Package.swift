// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: "7.0.0")
        ),
        .package(path: "./Worker"),
        .package(path: "./DesignSystem"),
        .package(path: "./Web")
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                .product(name: "Worker", package: "Worker"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Web", package: "Web"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"]
        ),
    ]
)
