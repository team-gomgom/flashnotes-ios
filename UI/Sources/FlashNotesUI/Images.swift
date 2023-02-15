// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Asset Catalogs

public enum Images {
  public static let icLogoCharacter = ImageAsset(name: "ic_logo_character")
  public static let icLogoTitle = ImageAsset(name: "ic_logo_title")
}

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  public typealias Image = UIImage

  public var image: Image {
    let bundle = BundleToken.bundle
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  convenience init?(asset: ImageAsset) {
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
