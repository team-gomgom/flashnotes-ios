//
//  AppRootRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import LoggedIn
import LoggedInImp
import ModernRIBs

protocol AppRootInteractable: Interactable, LoggedInListener {
  var router: AppRootRouting? { get set }
}

protocol AppRootViewControllable: ViewControllable {}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable> {
  private let loggedInBuildable: LoggedInBuildable
  private var loggedInRouting: Routing?

  init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable,
    loggedInBuildable: LoggedInBuildable
  ) {
    self.loggedInBuildable = loggedInBuildable
    super.init(interactor: interactor, viewController: viewController)

    interactor.router = self
  }
}

// MARK: - AppRootRouting

extension AppRootRouter: AppRootRouting {
  func routeToLoggedIn(token: String) {
    let loggedInRouting = loggedInBuildable.build(withListener: interactor, token: token)
    self.loggedInRouting = loggedInRouting
    attachChild(loggedInRouting)
  }
}
