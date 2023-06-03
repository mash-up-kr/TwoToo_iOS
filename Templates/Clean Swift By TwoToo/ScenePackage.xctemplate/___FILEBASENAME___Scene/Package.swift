// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "___VARIABLE_sceneName___Scene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "___VARIABLE_sceneName___Scene",
            targets: ["___VARIABLE_sceneName___Scene"]
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
            name: "___VARIABLE_sceneName___Scene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "___VARIABLE_sceneName___SceneTests",
            dependencies: [
                "___VARIABLE_sceneName___Scene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
