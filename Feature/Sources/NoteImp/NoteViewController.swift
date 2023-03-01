//
//  NoteViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import FlashNotesUI
import ModernRIBs
import Resource
import UIKit

protocol NotePresentableListener: AnyObject {
  func didTapTrainingButton()
  func didTapAddNote()
  func didTapDeleteNote()
}

final class NoteViewController: UIViewController,
                                NotePresentable,
                                NoteViewControllable {
  weak var listener: NotePresentableListener?

  private let pageListView = PageListView()

  private lazy var moreButton = UIBarButtonItem(
    image: UIImage(systemName: "ellipsis"),
    style: .plain,
    target: self,
    action: #selector(moreButtonDidTap)
  )

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
    navigationItem.rightBarButtonItem = moreButton
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
  private func moreButtonDidTap() {
    presentManagement()
  }

  @objc
  private func trainingButtonDidTap() {
    listener?.didTapTrainingButton()
  }
}

// MARK: - NoteManagement

private extension NoteViewController {
  func presentManagement() {
    let cancelAction = UIAlertAction(title: L10n.Action.cancel, style: .cancel)
    
    let addTitle = L10n.Action.addPage
    let addImage = UIImage(systemName: "plus")
    let addAction = alertAction(title: addTitle, image: addImage) { [weak self] in
      self?.listener?.didTapAddNote()
    }

    let deleteTitle = L10n.Action.deleteNote
    let deleteImage = UIImage(systemName: "trash")
    let deleteAction = alertAction(title: deleteTitle, image: deleteImage) { [weak self] in
      self?.listener?.didTapDeleteNote()
    }

    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actionSheet.view.tintColor = Colors.textGray.color
    actionSheet.addAction(addAction)
    actionSheet.addAction(deleteAction)
    actionSheet.addAction(cancelAction)
    present(actionSheet, animated: true)
  }

  func alertAction(
    title: String,
    image: UIImage?,
    handler: (() -> Void)? = nil
  ) -> UIAlertAction {
    let alertAction = UIAlertAction(title: title, style: .default) { _ in handler?() }
    alertAction.setValue(image, forKey: "image")
    alertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
    return alertAction
  }
}
