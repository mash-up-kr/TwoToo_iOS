// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "LoginScene",
            targets: ["LoginScene"]
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
            url: "https://github.com/kakao/kakao-ios-sdk",
            .upToNextMajor(from: "2.0.0")
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            .upToNextMajor(from: "10.0.0")
        )
    ],
    targets: [
        .target(
            name: "LoginScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "KakaoSDK", package: "kakao-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "LoginSceneTests",
            dependencies: [
                "LoginScene",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick")
            ]
        )
    ]
)
