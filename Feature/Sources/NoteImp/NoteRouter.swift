//
//  NoteRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note
import Page
import PageImp
import RIBsUtil

protocol NoteInteractable: Interactable, PageListener {
  var router: NoteRouting? { get set }
  var listener: NoteListener? { get set }
  var navigationDelegateProxy: NaviagationControllerDelegateProxy { get }

  func navigationControllerDidPush()
  func navigationControllerDidPop()
}

protocol NoteViewControllable: ViewControllable {}

final class NoteRouter: ViewableRouter<NoteInteractable, NoteViewControllable> {
  private let pageBuildable: PageBuildable
  private var pageRouting: ViewableRouting?

  init(
    interactor: NoteInteractable,
    viewController: NoteViewControllable,
    pageBuildable: PageBuildable
  ) {
    self.pageBuildable = pageBuildable
    super.init(interactor: interactor, viewController: viewController)
    
    interactor.router = self
  }
}

// MARK: - NoteRouting

extension NoteRouter: NoteRouting {
  func attachPage() {
    guard pageRouting == nil else { return }

    let routing = pageBuildable.build(withListener: interactor)
    viewController.uiviewController.navigationController?.delegate = interactor.navigationDelegateProxy
    interactor.navigationDelegateProxy.startObserving(parent: viewController.uiviewController)
    viewControllable.pushViewController(routing.viewControllable, animated: true)
    interactor.navigationControllerDidPush()

    pageRouting = routing
    attachChild(routing)
  }

  func detachPage() {
    guard let routing = pageRouting else { return }
    routing.viewControllable.popViewController(animated: true)
    interactor.navigationControllerDidPop()

    detachChild(routing)
    pageRouting = nil
  }
}
