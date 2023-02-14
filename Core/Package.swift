// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v14)],
    products: [
      .library(
        name: "CombineUtil",
        targets: ["CombineUtil"]
      ),
      .library(
        name: "Network",
        targets: ["Network"]
      ),
      .library(
        name: "NetworkImp",
        targets: ["NetworkImp"]
      ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/CombineCommunity/CombineExt",
        from: "1.0.0"
      ),
    ],
    targets: [
      .target(
        name: "CombineUtil",
        dependencies: ["CombineExt"]
      ),
      .target(
        name: "Network"
      ),
      .target(
        name: "NetworkImp",
        dependencies: ["Network"]
      ),
    ]
)
