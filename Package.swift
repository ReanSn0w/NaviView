// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NaviView",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NaviView",
            targets: ["NaviView"]),
    ],
    dependencies: [
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.3")
    ],
    targets: [
        .target(
            name: "NaviView",
            dependencies: ["Introspect"]),
    ]
)
