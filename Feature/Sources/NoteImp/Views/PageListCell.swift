//
//  PageListCell.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import FlashNotesUI
import Resource
import UIKit

final class PageListCell: UITableViewCell {
  private let questionImageView: UIImageView = {
    let imageView = UIImageView(image: Images.icQOrange.image)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let questionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setup()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    contentView.backgroundColor = .secondarySystemBackground
    selectionStyle = .none
  }

  private func setupLayout() {
    questionImageView.translatesAutoresizingMaskIntoConstraints = false
    questionLabel.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(questionImageView)
    contentView.addSubview(questionLabel)

    NSLayoutConstraint.activate([
      questionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      questionImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
      questionLabel.topAnchor.constraint(equalTo: questionImageView.bottomAnchor, constant: 15),
      questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
      questionLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20),
      questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}

extension PageListCell {
  func configure(viewModel: PageListCellViewModel) {
    questionLabel.attributedText = Text(
      string: viewModel.question,
      font: .systemFont(ofSize: 15, weight: .medium),
      color: Colors.textGray.color
    )
  }
}
