// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeCreateScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeEssentialInfoInputScene",
            targets: ["ChallengeEssentialInfoInputScene"]
        ),
        .library(
            name: "ChallengeAdditionalInfoInputScene",
            targets: ["ChallengeAdditionalInfoInputScene"]
        ),
        .library(
            name: "ChallengeRecommendScene",
            targets: ["ChallengeRecommendScene"]
        ),
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
        ),
        .package(path: "./ChallengeConfirmScene")
    ],
    targets: [
        .target(
            name: "ChallengeEssentialInfoInputScene",
            dependencies: [
                "ChallengeRecommendScene",
                "ChallengeAdditionalInfoInputScene"
            ]
        ),
        .testTarget(
            name: "ChallengeEssentialInfoInputSceneTests",
            dependencies: [
                "ChallengeEssentialInfoInputScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        ),
        .target(
            name: "ChallengeAdditionalInfoInputScene",
            dependencies: [
                .product(name: "ChallengeConfirmScene", package: "ChallengeConfirmScene")
            ]
        ),
        .testTarget(
            name: "ChallengeAdditionalInfoInputSceneTests",
            dependencies: [
                "ChallengeAdditionalInfoInputScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        ),
        .target(
            name: "ChallengeRecommendScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "ChallengeRecommendSceneTests",
            dependencies: [
                "ChallengeRecommendScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        ),
    ]
)
