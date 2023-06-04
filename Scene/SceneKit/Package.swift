// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SceneKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SceneKit",
            targets: ["SceneKit"]
        ),
    ],
    dependencies: [
        .package(path: "./SplashScene"),
        .package(path: "./NicknameRegistScene"),
        .package(path: "./LoginScene"),
        .package(path: "./MainScene")
    ],
    targets: [
        .target(
            name: "SceneKit",
            dependencies: [
                .product(name: "SplashScene", package: "SplashScene"),
                .product(name: "NicknameRegistScene", package: "NicknameRegistScene"),
                .product(name: "LoginScene", package: "LoginScene"),
                .product(name: "MainScene", package: "MainScene")
            ]
        ),
        .testTarget(
            name: "SceneKitTests",
            dependencies: ["SceneKit"]
        ),
    ]
)
