// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataStructuresAndAlgorithms",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        // Library product for importing in other projects
        .library(
            name: "DataStructuresAndAlgorithms",
            targets: ["DataStructuresAndAlgorithms"]),
        // Executable for running examples and demos
        .executable(
            name: "Examples",
            targets: ["Examples"])
    ],
    targets: [
        // Main library target containing all data structures and algorithms
        .target(
            name: "DataStructuresAndAlgorithms",
            dependencies: []),

        // Examples executable to demonstrate usage
        .executableTarget(
            name: "Examples",
            dependencies: ["DataStructuresAndAlgorithms"]),

        // Test target
        .testTarget(
            name: "DataStructuresAndAlgorithmsTests",
            dependencies: ["DataStructuresAndAlgorithms"])
    ]
)
