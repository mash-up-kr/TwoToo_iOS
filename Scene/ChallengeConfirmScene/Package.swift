// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeConfirmScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeConfirmScene",
            targets: ["ChallengeConfirmScene"]
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
        .package(path: "./FlowerSelectScene")
    ],
    targets: [
        .target(
            name: "ChallengeConfirmScene",
            dependencies: [
                .product(name: "FlowerSelectScene", package: "FlowerSelectScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "ChallengeConfirmSceneTests",
            dependencies: [
                "ChallengeConfirmScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
