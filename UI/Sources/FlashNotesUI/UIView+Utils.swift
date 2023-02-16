//
//  UIView+Utils.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

public extension UIView {
  func round() {
    layer.cornerRadius = frame.height / 2
    layer.cornerCurve = .circular
  }
}
