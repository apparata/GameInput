// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "GameInput",
    platforms: [
        // Relevant platforms.
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .visionOS(.v1)
    ],
    products: [
        .library(name: "GameInput", targets: ["GameInput"])
    ],
    targets: [
        .target(
            name: "GameInput",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ]),
    ]
)
