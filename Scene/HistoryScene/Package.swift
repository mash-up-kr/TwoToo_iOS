// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HistoryScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HistoryScene",
            targets: ["HistoryScene"]
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
        .package(path: "./ChallengeHistoryScene")
    ],
    targets: [
        .target(
            name: "HistoryScene",
            dependencies: [
                .product(name: "ChallengeHistoryScene", package: "ChallengeHistoryScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "HistorySceneTests",
            dependencies: [
                "HistoryScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
