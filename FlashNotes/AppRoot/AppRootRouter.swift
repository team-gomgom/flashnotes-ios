//
//  AppRootRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import ModernRIBs

protocol AppRootInteractable: Interactable {
  var router: AppRootRouting? { get set }
}

protocol AppRootViewControllable: ViewControllable {}

final class AppRootRouter: LaunchRouter<AppRootInteractable,
                           AppRootViewControllable>,
                           AppRootRouting {
  override init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
