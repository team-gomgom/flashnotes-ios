//
//  SlideMenuRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import SlideMenu

protocol SlideMenuInteractable: Interactable {
  var router: SlideMenuRouting? { get set }
  var listener: SlideMenuListener? { get set }
}

protocol SlideMenuViewControllable: ViewControllable {}

final class SlideMenuRouter: ViewableRouter<SlideMenuInteractable,
                             SlideMenuViewControllable>,
                             SlideMenuRouting {
  override init(
    interactor: SlideMenuInteractable,
    viewController: SlideMenuViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    
    interactor.router = self
  }
}
