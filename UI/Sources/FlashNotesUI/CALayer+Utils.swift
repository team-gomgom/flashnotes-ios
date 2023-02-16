//
//  CALayer+Utils.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

public final class ShadowLayer: CALayer {
  public init(
    color: UIColor? = .black,
    opacity: Float = 0.1,
    offSet: CGSize,
    blur: CGFloat
  ) {
    super.init()

    masksToBounds = false
    shadowColor = color?.cgColor
    shadowOpacity = opacity
    shadowOffset = offSet
    shadowRadius = blur / 2
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public func setPath(view: UIView) {
    shadowPath = UIBezierPath(
      roundedRect: view.bounds,
      cornerRadius: view.layer.cornerRadius
    ).cgPath
  }
}
