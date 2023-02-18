//
//  MainRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs
import SlideMenu
import SlideMenuImp

protocol MainInteractable: Interactable, SlideMenuListener {
  var router: MainRouting? { get set }
  var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
  func setMenuViewController(_ viewControllable: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable> {
  private let slideMenuBuildable: SlideMenuBuildable
  private var slideMenuRouting: ViewableRouting?

  init(
    interactor: MainInteractable,
    viewController: MainViewControllable,
    slideMenuBuildable: SlideMenuBuildable
  ) {
    self.slideMenuBuildable = slideMenuBuildable
    super.init(interactor: interactor, viewController: viewController)

    interactor.router = self
  }
}

// MARK: - MainRouting

extension MainRouter: MainRouting {
  func attachSlideMenu() {
    guard slideMenuRouting == nil else { return }

    let routing = slideMenuBuildable.build(withListener: interactor)
    viewController.setMenuViewController(routing.viewControllable)

    slideMenuRouting = routing
    attachChild(routing)
  }
}
