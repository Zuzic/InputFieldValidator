// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InputValidator",
    platforms: [
           .iOS(.v12),
       ],
    products: [
        .library(
            name: "InputValidator",
            targets: ["InputValidator"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "InputValidator",
            dependencies: [],
            resources: [
                        .process("TextRegexes.plist")])
    ],
    swiftLanguageVersions: [.v5]
)
