// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v14)],
    products: [
      .library(
        name: "Entity",
        targets: ["Entity"]
      ),
      .library(
        name: "LoggedIn",
        targets: ["LoggedIn"]
      ),
      .library(
        name: "LoggedInImp",
        targets: ["LoggedInImp"]
      ),
      .library(
        name: "Main",
        targets: ["Main"]
      ),
      .library(
        name: "MainImp",
        targets: ["MainImp"]
      ),
      .library(
        name: "Note",
        targets: ["Note"]
      ),
      .library(
        name: "NoteImp",
        targets: ["NoteImp"]
      ),
      .library(
        name: "Page",
        targets: ["Page"]
      ),
      .library(
        name: "PageImp",
        targets: ["PageImp"]
      ),
      .library(
        name: "Repository",
        targets: ["Repository"]
      ),
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
        name: "Entity"
      ),
      .target(
        name: "LoggedIn",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "LoggedInImp",
        dependencies: [
          "LoggedIn",
          "Main",
          "MainImp",
          "ModernRIBs",
          .product(name: "RIBsUtil", package: "Core"),
        ]
      ),
      .target(
        name: "Main",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "MainImp",
        dependencies: [
          "Entity",
          "Main",
          "ModernRIBs",
          "Note",
          "NoteImp",
          "SlideMenu",
          "SlideMenuImp",
          .product(name: "Resource", package: "Core"),
          .product(name: "FlashNotesUI", package: "UI"),
        ]
      ),
      .target(
        name: "Note",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "NoteImp",
        dependencies: [
          "Entity",
          "Note",
          "Page",
          "PageImp",
          "ModernRIBs",
          .product(name: "Resource", package: "Core"),
          .product(name: "RIBsUtil", package: "Core"),
          .product(name: "FlashNotesUI", package: "UI"),
        ]
      ),
      .target(
        name: "Page",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "PageImp",
        dependencies: [
          "Entity",
          "Page",
          "ModernRIBs",
          .product(name: "Resource", package: "Core"),
          .product(name: "FlashNotesUI", package: "UI"),
        ]
      ),
      .target(
        name: "Repository",
        dependencies: [
          "Entity",
        ]
      ),
      .target(
        name: "SlideMenu",
        dependencies: ["ModernRIBs"]
      ),
      .target(
        name: "SlideMenuImp",
        dependencies: [
          "Entity",
          "SlideMenu",
          "ModernRIBs",
          .product(name: "Resource", package: "Core"),
          .product(name: "FlashNotesUI", package: "UI"),
        ]
      ),
    ]
)
