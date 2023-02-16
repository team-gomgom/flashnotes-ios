//
//  Text.swift
//  
//
//  Created by 정동천 on 2023/02/17.
//

import UIKit

public typealias Text = NSMutableAttributedString

public extension Text {
  convenience init(
    string: String,
    font: UIFont,
    color: UIColor,
    lineSpacing: CGFloat = 2,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byTruncatingTail
  ) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.alignment = alignment
    paragraphStyle.lineBreakMode = lineBreakMode
    let attributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: color,
      .paragraphStyle: paragraphStyle
    ]
    self.init(string: string, attributes: attributes)
  }

  func append(
    string: String,
    font: UIFont,
    color: UIColor,
    lineSpacing: CGFloat = 2,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byTruncatingTail
  ) {
    let text = Text(
      string: string,
      font: font,
      color: color,
      lineSpacing: lineSpacing,
      alignment: alignment
    )
    append(text)
  }
}
