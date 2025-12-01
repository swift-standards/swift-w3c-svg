// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-w3c-svg",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
    ],
    products: [
        .library(
            name: "W3C SVG",
            targets: ["W3C SVG"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-standards/swift-numeric-formatting-standard",
            from: "0.1.0"
        )
    ],
    targets: [
        .target(
            name: "W3C SVG",
            dependencies: [
                .product(name: "Numeric Formatting", package: "swift-numeric-formatting-standard")
            ]
        ),
        .testTarget(
            name: "W3C SVG Tests",
            dependencies: ["W3C SVG"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings =
        existing + [
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
        ]
}
