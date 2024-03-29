// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeHistoryDetailScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeHistoryDetailScene",
            targets: ["ChallengeHistoryDetailScene"]
        )
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(
            url: "https://github.com/suzuki-0000/SKPhotoBrowser",
            .upToNextMajor(from: "7.0.0")
        ),
        .package(
            url: "https://github.com/Quick/Nimble",
            .upToNextMajor(from: "12.0.0")
        ),
        .package(
            url: "https://github.com/Quick/Quick",
            .upToNextMajor(from: "6.0.0")
        )
    ],
    targets: [
        .target(
            name: "ChallengeHistoryDetailScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "SKPhotoBrowser", package: "SKPhotoBrowser")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "ChallengeHistoryDetailSceneTests",
            dependencies: [
                "ChallengeHistoryDetailScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
