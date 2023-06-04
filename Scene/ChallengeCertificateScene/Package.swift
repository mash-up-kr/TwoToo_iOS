// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChallengeCertificateScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChallengeCertificateScene",
            targets: ["ChallengeCertificateScene"]
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
            name: "ChallengeCertificateScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "ChallengeCertificateSceneTests",
            dependencies: [
                "ChallengeCertificateScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
