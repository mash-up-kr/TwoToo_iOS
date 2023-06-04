// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MainScene",
            targets: ["MainScene"]
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
        .package(path: "./HomeScene"),
        .package(path: "./HistoryScene"),
        .package(path: "./MyInfoScene")
    ],
    targets: [
        .target(
            name: "MainScene",
            dependencies: [
                .product(name: "HomeScene", package: "HomeScene"),
                .product(name: "HistoryScene", package: "HistoryScene"),
                .product(name: "MyInfoScene", package: "MyInfoScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "MainSceneTests",
            dependencies: [
                "MainScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
