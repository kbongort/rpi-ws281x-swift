// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rpi-ws281x-swift",
    products: [
        // 
        .library(
            name: "rpi_ws281x_swift",
            targets: ["rpi_ws281x_swift"]),
        .library(
            name: "rpi_ws281x",
            targets: ["rpi_ws281x"]),
        .executable(name: "Demo", targets: ["Demo"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "rpi_ws281x_swift",
            dependencies: ["rpi_ws281x"]),
        // Contains rpi_ws281x C sources.
        .target(name: "rpi_ws281x"),
        // A demo of the library.
        .executableTarget(name: "Demo", dependencies: ["rpi_ws281x_swift"])
    ]
)
