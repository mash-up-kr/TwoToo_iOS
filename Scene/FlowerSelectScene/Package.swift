// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowerSelectScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "FlowerSelectScene",
            targets: ["FlowerSelectScene"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble",
            .upToNextMajor(from: "12.0.0")
        ),
        .package(
            url: "https://github.com/Quick/Quick",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(path: "./ChallengeCreateFinishScene")
    ],
    targets: [
        .target(
            name: "FlowerSelectScene",
            dependencies: [
                .product(name: "ChallengeCreateFinishScene", package: "ChallengeCreateFinishScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "FlowerSelectSceneTests",
            dependencies: [
                "FlowerSelectScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
