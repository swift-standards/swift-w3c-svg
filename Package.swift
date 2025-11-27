// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-w3c-svg",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: "W3C SVG",
            targets: ["W3C SVG"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "W3C SVG",
            dependencies: []
        ),
        .testTarget(
            name: "W3C SVG Tests",
            dependencies: ["W3C SVG"]
        )
    ],
    swiftLanguageModes: [.v6]
)

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("StrictUnsafe"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault")
]

for index in package.targets.indices {
    package.targets[index].swiftSettings = (package.targets[index].swiftSettings ?? []) + swiftSettings
}
