// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "macos-mac-address",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "MacAddress", targets: ["MacAddress"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MacAddress",
            dependencies: []
        ),
        .testTarget(
            name: "MacAddressTests",
            dependencies: ["MacAddress"]
        )
    ]
)
