// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]
        ),
    ],
    dependencies: [
        .package(path: "./Util"),
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMajor(from: "5.0.0")
        )
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .product(name: "Util", package: "Util"),
                .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]
        ),
    ]
)
