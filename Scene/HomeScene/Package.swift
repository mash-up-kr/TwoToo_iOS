// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HomeScene",
            targets: ["HomeScene"]
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
        .package(path: "./ChallengeCreateScene"),
        .package(path: "./NudgeSendScene"),
        .package(path: "./ChallengeHistoryScene"),
        .package(path: "./PraiseSendScene")
    ],
    targets: [
        .target(
            name: "HomeScene",
            dependencies: [
                .product(name: "ChallengeEssentialInfoInputScene", package: "ChallengeCreateScene"),
                .product(name: "NudgeSendScene", package: "NudgeSendScene"),
                .product(name: "ChallengeHistoryScene", package: "ChallengeHistoryScene"),
                .product(name: "PraiseSendScene", package: "PraiseSendScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "HomeSceneTests",
            dependencies: [
                "HomeScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
