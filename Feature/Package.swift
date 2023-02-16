// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v14)],
    products: [
      .library(
        name: "SlideMenu",
        targets: ["SlideMenu"]
      ),
      .library(
        name: "SlideMenuImp",
        targets: ["SlideMenuImp"]
      ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/DevYeom/ModernRIBs",
        .upToNextMajor(from: "1.0.0")
      ),
      .package(path: "../Core"),
      .package(path: "../UI"),
    ],
    targets: [
      .target(
        name: "SlideMenu",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "SlideMenuImp",
        dependencies: [
          "SlideMenu",
          "ModernRIBs",
          .product(name: "Entity", package: "Core"),
          .product(name: "FlashNotesUI", package: "UI"),
        ]
      ),
    ]
)
