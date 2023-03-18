//
//  PageAnswerView.swift
//  
//
//  Created by 정동천 on 2023/03/02.
//

import Resource
import UIKit

final class PageAnswerView: UIView {

  var answer: String { answerTextView.text ?? "" }

  private let answerImageView: UIImageView = {
    let imageView = UIImageView()
    let image = Images.icAOrange.image.withRenderingMode(.alwaysTemplate)
    imageView.image = image
    imageView.tintColor = .systemOrange
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let answerTextView: UITextView = {
    let textView = UITextView()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 5
    textView.typingAttributes = [
      .foregroundColor: Colors.textGray.color,
      .font: UIFont.systemFont(ofSize: 16, weight: .regular),
      .paragraphStyle: paragraphStyle
    ]
    textView.backgroundColor = .clear
    textView.tintColor = Colors.textGray.color
    textView.contentInset = .zero
    textView.textContainerInset = .zero
    return textView
  }()

  init() {
    super.init(frame: .zero)

    setup()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    backgroundColor = .secondarySystemBackground
  }

  private func setupLayout() {
    answerImageView.translatesAutoresizingMaskIntoConstraints = false
    answerTextView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(answerImageView)
    addSubview(answerTextView)

    NSLayoutConstraint.activate([
      answerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      answerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
      answerTextView.topAnchor.constraint(equalTo: answerImageView.bottomAnchor, constant: 20),
      answerTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      answerTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      answerTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
    ])
  }
}
