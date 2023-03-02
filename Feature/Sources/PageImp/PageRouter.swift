//
//  PageRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs
import Page

protocol PageInteractable: Interactable {
  var router: PageRouting? { get set }
  var listener: PageListener? { get set }
}

protocol PageViewControllable: ViewControllable {}

final class PageRouter: ViewableRouter<PageInteractable, PageViewControllable>,
                        PageRouting {
  override init(interactor: PageInteractable, viewController: PageViewControllable) {
    super.init(interactor: interactor, viewController: viewController)

    interactor.router = self
  }
}
