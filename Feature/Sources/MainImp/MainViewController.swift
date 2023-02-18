//
//  MainViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import FlashNotesUI
import ModernRIBs
import UIKit

protocol MainPresentableListener: AnyObject {}

final class MainViewController: SlideController,
                                MainPresentable {
  weak var listener: MainPresentableListener?

  init() {
    let navigationController = UINavigationController()
    super.init(
      navigationController: navigationController
    )
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

// MARK: - MainViewControllable

extension MainViewController: MainViewControllable {
  func setMenuViewController(_ viewControllable: ViewControllable) {
    let viewController = viewControllable.uiviewController
    slideMenuViewController = UINavigationController(rootViewController: viewController)
  }
}
