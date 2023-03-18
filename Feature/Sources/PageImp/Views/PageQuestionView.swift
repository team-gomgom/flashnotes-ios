//
//  PageQuestionView.swift
//  
//
//  Created by 정동천 on 2023/03/02.
//

import Resource
import UIKit

final class PageQuestionView: UIView {

  var question: String { questionTextView.text ?? "" }

  private let questionImageView: UIImageView = {
    let imageView = UIImageView()
    let image = Images.icQWhite.image.withRenderingMode(.alwaysTemplate)
    imageView.image = image
    imageView.tintColor = .secondarySystemBackground
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let questionTextView: UITextView = {
    let textView = UITextView()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 6
    textView.typingAttributes = [
      .foregroundColor: UIColor.secondarySystemBackground,
      .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
      .paragraphStyle: paragraphStyle
    ]
    textView.backgroundColor = .clear
    textView.tintColor = .secondarySystemBackground
    textView.indicatorStyle = .black
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
    backgroundColor = .systemOrange
  }

  private func setupLayout() {
    questionImageView.translatesAutoresizingMaskIntoConstraints = false
    questionTextView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(questionImageView)
    addSubview(questionTextView)

    NSLayoutConstraint.activate([
      questionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      questionImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
      questionTextView.topAnchor.constraint(equalTo: questionImageView.bottomAnchor, constant: 20),
      questionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      questionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      questionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
    ])
  }
}
