// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeCreateFinishScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeCreateFinishScene",
            targets: ["ChallengeCreateFinishScene"]
        )
    ],
    dependencies: [
        .package(path: "./CoreKit"),
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
            name: "ChallengeCreateFinishScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "ChallengeCreateFinishSceneTests",
            dependencies: [
                "ChallengeCreateFinishScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
