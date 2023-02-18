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
import Note
import NoteImp

protocol MainInteractable: Interactable, SlideMenuListener, NoteListener {
  var router: MainRouting? { get set }
  var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
  func setMenuViewController(_ viewControllable: ViewControllable)
  func setRootViewController(_ viewControllable: ViewControllable)
  func popRootViewController()
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable> {
  private let slideMenuBuildable: SlideMenuBuildable
  private var slideMenuRouting: ViewableRouting?

  private let noteBuildable: NoteBuildable
  private var noteRouting: ViewableRouting?

  init(
    interactor: MainInteractable,
    viewController: MainViewControllable,
    slideMenuBuildable: SlideMenuBuildable,
    noteBuildable: NoteBuildable
  ) {
    self.slideMenuBuildable = slideMenuBuildable
    self.noteBuildable = noteBuildable
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

  func attachNote() {
    guard noteRouting == nil else { return }

    let routing = noteBuildable.build(withListener: interactor)
    viewController.setRootViewController(routing.viewControllable)

    noteRouting = routing
    attachChild(routing)
  }

  func detachNote() {
    guard let routing = noteRouting else { return }

    viewController.popRootViewController()
    
    detachChild(routing)
    noteRouting = nil
  }
}
