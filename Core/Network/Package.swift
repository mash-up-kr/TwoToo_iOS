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
        ),
        .package(
            url: "https://github.com/ashleymills/Reachability.swift",
            .upToNextMajor(from: "5.0.0")
        )
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .product(name: "Util", package: "Util"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Reachability", package: "Reachability.swift")
            ]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]
        ),
    ]
)
