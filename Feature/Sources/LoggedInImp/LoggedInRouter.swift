//
//  LoggedInRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/18.
//

import LoggedIn
import Main
import MainImp
import ModernRIBs
import RIBsUtil

protocol LoggedInInteractable: Interactable, MainListener {
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

final class LoggedInRouter: Router<LoggedInInteractable> {
  private let viewController: ViewControllable
  private let mainBuildable: MainBuildable
  private var mainRouting: ViewableRouting?

  init(
    interactor: LoggedInInteractable,
    viewController: ViewControllable,
    mainBuildable: MainBuildable
  ) {
    self.viewController = viewController
    self.mainBuildable = mainBuildable
    super.init(interactor: interactor)

    interactor.router = self
  }

  func cleanupViews() {}
}

// MARK: - LoggedInRouting

extension LoggedInRouter: LoggedInRouting {
  func routeToMain() {
    guard mainRouting == nil else { return }

    let routing = mainBuildable.build(withListener: interactor)
    viewController.present(
      routing.viewControllable,
      modalPresentationStyle: .fullScreen,
      animated: false
    )
    mainRouting = routing
    attachChild(routing)
  }
}
