//
//  NoteViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import FlashNotesUI
import ModernRIBs
import UIKit

protocol NotePresentableListener: AnyObject {
  func didTapTrainingButton()
}

final class NoteViewController: UIViewController,
                                NotePresentable,
                                NoteViewControllable {
  weak var listener: NotePresentableListener?

  private let pageListView = PageListView()

  private lazy var trainingButton: FloatingButton = {
    let image = Images.icCards.image
    let button = FloatingButton(image: image)
    let action = #selector(trainingButtonDidTap)
    button.addTarget(self, action: action, for: .touchUpInside)
    button.setBackgorundColor(Colors.backgroundOrange.color, for: .normal)
    button.setBackgorundColor(Colors.HighlightedOrange.color, for: .highlighted)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupLayout()
  }

  private func setup() {
    view.backgroundColor = .secondarySystemBackground
  }

  private func setupLayout() {
    pageListView.translatesAutoresizingMaskIntoConstraints = false
    trainingButton.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(pageListView)
    view.addSubview(trainingButton)

    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      pageListView.topAnchor.constraint(equalTo: view.topAnchor),
      pageListView.leftAnchor.constraint(equalTo: view.leftAnchor),
      pageListView.rightAnchor.constraint(equalTo: view.rightAnchor),
      pageListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      trainingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      trainingButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
      trainingButton.widthAnchor.constraint(equalToConstant: 50),
      trainingButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  @objc
  private func trainingButtonDidTap() {
    listener?.didTapTrainingButton()
  }
}
