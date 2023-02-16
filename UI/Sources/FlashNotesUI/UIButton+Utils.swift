//
//  UIButton+Utils.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

public extension UIButton {
  func setBackgorundColor(_ color: UIColor, for state: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.setFillColor(color.cgColor)
    context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    setBackgroundImage(backgroundImage, for: state)
  }
}
