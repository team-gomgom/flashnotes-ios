//
//  NoteListCell.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import FlashNotesUI
import Resource
import UIKit

final class NoteListCell: UITableViewCell {
  private let accessoryImageView: UIImageView = {
    let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
    let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
    let imageView = UIImageView(image: image)
    return imageView
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
    backgroundColor = Colors.backgroundOrange.color

    let selectedView = UIView()
    selectedView.backgroundColor = Colors.HighlightedOrange.color
    selectedBackgroundView = selectedView

    tintColor = .white

    imageView?.image = UIImage(systemName: "doc.text.fill")
    textLabel?.textColor = Colors.textWhite.color
    textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
  }

  private func setupLayout() {
    accessoryImageView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(accessoryImageView)

    NSLayoutConstraint.activate([
      accessoryImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
      accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}

extension NoteListCell {
  func configure(viewModel: NoteListCellViewModel) {
    textLabel?.text = viewModel.title
  }
}
