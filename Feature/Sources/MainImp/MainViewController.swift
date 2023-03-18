//
//  MainViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import FlashNotesUI
import ModernRIBs
import Resource
import UIKit

protocol MainPresentableListener: AnyObject {
  func createNote(title: String)
}

final class MainViewController: SlideController {
  weak var listener: MainPresentableListener?

  init() {
    let navigationController = UINavigationController()
    super.init(navigationController: navigationController)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    slideBarButtonItem.image = Images.icMenu.image
  }
}

// MARK: - MainViewControllable

extension MainViewController: MainViewControllable {
  func setMenuViewController(_ viewControllable: ViewControllable) {
    let viewController = viewControllable.uiviewController
    let navigationController = UINavigationController(rootViewController: viewController)
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithTransparentBackground()
    navigationBarAppearance.backgroundColor = viewController.view.backgroundColor
    navigationController.navigationBar.standardAppearance = navigationBarAppearance
    navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    slideMenuViewController = navigationController
  }

  func setRootViewController(_ viewControllable: ViewControllable) {
    rootViewController = viewControllable.uiviewController
  }

  func popRootViewController() {
    rootViewController = nil
  }
}

// MARK: - MainPresentable

extension MainViewController: MainPresentable {
  func updateGestureEnabledState(_ state: Bool) {
    isGestureEnabled = state
  }

  func presentNoteCreation() {
    let title = L10n.Alert.NoteCreation.title
    let message = L10n.Alert.NoteCreation.message
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let cancelTitle = L10n.Action.cancel
    let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive)

    let doneTitle = L10n.Action.done
    let doneAction = UIAlertAction(title: doneTitle, style: .default) { [listener] _ in
      let title = alert.textFields?.first?.text ?? ""
      listener?.createNote(title: title)
    }

    alert.addAction(cancelAction)
    alert.addAction(doneAction)
    alert.addTextField { textField in
      textField.textAlignment = .center
    }
    present(alert, animated: true)
  }
}
