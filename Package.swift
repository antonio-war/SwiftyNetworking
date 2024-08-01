// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SwiftyNetworking",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "SwiftyNetworking",
            targets: ["SwiftyNetworking"]),
    ],
    targets: [
        .target(
            name: "SwiftyNetworking"),
        .testTarget(
            name: "SwiftyNetworkingTests",
            dependencies: ["SwiftyNetworking"]),
    ]
)
