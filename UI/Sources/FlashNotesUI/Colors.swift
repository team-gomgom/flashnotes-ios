// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Asset Catalogs

public enum Colors {
  public static let backgroundOrange = ColorAsset(name: "BackgroundOrange")
  public static let backgroundWhite = ColorAsset(name: "BackgroundWhite")
  public static let dimLight = ColorAsset(name: "DimLight")
  public static let primaryOrange = ColorAsset(name: "PrimaryOrange")
  public static let textBlack = ColorAsset(name: "TextBlack")
  public static let textGray = ColorAsset(name: "TextGray")
  public static let textWhite = ColorAsset(name: "TextWhite")
}

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  public typealias Color = UIColor

  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
#if SWIFT_PACKAGE
    return Bundle.module
#else
    return Bundle(for: BundleToken.self)
#endif
  }()
}
