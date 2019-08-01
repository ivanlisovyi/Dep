// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Dep",
    products: [
        .library(
            name: "Dep",
            targets: ["Dep"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Dep",
            dependencies: []),
        .testTarget(
            name: "DepTests",
            dependencies: ["Dep"]),
    ]
)
