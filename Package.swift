// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RXExts",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_11),
        .tvOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RXExts",
            targets: ["RXExts"]),
    ],
    dependencies: [
        // 依赖日志
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "RXExts",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "SnapKit", package: "SnapKit"),
            ]),
        .testTarget(
            name: "RXExtsTests",
            dependencies: ["RXExts"]),
    ],
    swiftLanguageVersions: [.v5]
)