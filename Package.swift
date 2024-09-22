// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftyNetworking",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
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
    ],
    swiftLanguageVersions: [
        .version("6")
    ]
)
