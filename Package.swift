// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalWeb",
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "0.15.3")
    ],
    targets: [
        .executableTarget(
            name: "LocalWeb",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird")
            ]),
        .testTarget(
            name: "LocalWebTests",
            dependencies: ["LocalWeb"]),
    ]
)
