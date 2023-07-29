// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InvitationSendScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "InvitationSendScene",
            targets: ["InvitationSendScene"]
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
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            .upToNextMajor(from: "10.0.0")
        )
    ],
    targets: [
        .target(
            name: "InvitationSendScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "FirebaseDynamicLinks", package: "firebase-ios-sdk")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "InvitationSendSceneTests",
            dependencies: [
                "InvitationSendScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
