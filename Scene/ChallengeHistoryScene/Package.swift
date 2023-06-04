// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeHistoryScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeHistoryScene",
            targets: ["ChallengeHistoryScene"]
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
        .package(path: "./ChallengeHistoryDetailScene"),
        .package(path: "./ChallengeCertificateScene")
    ],
    targets: [
        .target(
            name: "ChallengeHistoryScene",
            dependencies: [
                .product(name: "ChallengeHistoryDetailScene", package: "ChallengeHistoryDetailScene"),
                .product(name: "ChallengeCertificateScene", package: "ChallengeCertificateScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "ChallengeHistorySceneTests",
            dependencies: [
                "ChallengeHistoryScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
