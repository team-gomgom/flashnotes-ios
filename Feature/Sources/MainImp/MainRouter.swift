//
//  MainRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs

protocol MainInteractable: Interactable {
  var router: MainRouting? { get set }
  var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>,
                        MainRouting {
  override init(
    interactor: MainInteractable,
    viewController: MainViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)

    interactor.router = self
  }
}
