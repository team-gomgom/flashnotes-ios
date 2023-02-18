//
//  LoggedInRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/18.
//

import LoggedIn
import ModernRIBs

protocol LoggedInInteractable: Interactable {
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

final class LoggedInRouter: Router<LoggedInInteractable>,
                            LoggedInRouting {
  init(interactor: LoggedInInteractable, viewController: ViewControllable) {
    self.viewController = viewController
    super.init(interactor: interactor)
    interactor.router = self
  }

  func cleanupViews() {}

  // MARK: - Private

  private let viewController: ViewControllable
}
