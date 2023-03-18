//
//  AddPageRouter.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import ModernRIBs
import Page

protocol AddPageInteractable: Interactable {
  var router: AddPageRouting? { get set }
  var listener: AddPageListener? { get set }
}

protocol AddPageViewControllable: ViewControllable {}

final class AddPageRouter: ViewableRouter<AddPageInteractable, AddPageViewControllable>,
                           AddPageRouting {
  
  override init(interactor: AddPageInteractable, viewController: AddPageViewControllable) {
    super.init(interactor: interactor, viewController: viewController)

    interactor.router = self
  }
}
