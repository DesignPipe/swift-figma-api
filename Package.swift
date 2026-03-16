// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "swift-figma-api",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "FigmaAPI", targets: ["FigmaAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mattt/swift-yyjson", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "FigmaAPI",
            dependencies: [
                .product(name: "YYJSON", package: "swift-yyjson"),
            ]
        ),
        .testTarget(
            name: "FigmaAPITests",
            dependencies: [
                "FigmaAPI",
                .product(name: "YYJSON", package: "swift-yyjson"),
                .product(name: "CustomDump", package: "swift-custom-dump"),
            ],
            resources: [
                .copy("Fixtures/"),
            ]
        ),
    ]
)
