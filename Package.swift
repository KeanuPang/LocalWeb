// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalWeb",
    platforms: [
        .macOS(.v10_14),
    ],
    products: [
        .executable(name: "localWeb", targets: ["LocalWeb"])
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "0.15.3"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.2.0"),
        .package(url: "https://github.com/thebarndog/swift-dotenv", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.2")
    ],
    targets: [
        .executableTarget(
            name: "LocalWeb",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),
                .product(name: "Files", package: "Files"),
                .product(name: "SwiftDotenv", package: "swift-dotenv"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "LocalWebTests",
            dependencies: ["LocalWeb"]),
    ]
)
