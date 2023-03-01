// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
      .library(
        name: "CombineUtil",
        targets: ["CombineUtil"]
      ),
      .library(
        name: "Entity",
        targets: ["Entity"]
      ),
      .library(
        name: "Network",
        targets: ["Network"]
      ),
      .library(
        name: "NetworkImp",
        targets: ["NetworkImp"]
      ),
      .library(
        name: "Resource",
        targets: ["Resource"]
      ),
      .library(
        name: "RIBsUtil",
        targets: ["RIBsUtil"]
      ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/CombineCommunity/CombineExt",
        from: "1.0.0"
      ),
      .package(
        url: "https://github.com/DevYeom/ModernRIBs",
        .upToNextMajor(from: "1.0.0")
      ),
    ],
    targets: [
      .target(
        name: "CombineUtil",
        dependencies: ["CombineExt"]
      ),
      .target(
        name: "Entity"
      ),
      .target(
        name: "Network"
      ),
      .target(
        name: "NetworkImp",
        dependencies: ["Network"]
      ),
      .target(
        name: "Resource"
      ),
      .target(
        name: "RIBsUtil",
        dependencies: ["ModernRIBs"]
      ),
    ]
)
