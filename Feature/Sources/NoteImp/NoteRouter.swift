//
//  NoteRouter.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note

protocol NoteInteractable: Interactable {
  var router: NoteRouting? { get set }
  var listener: NoteListener? { get set }
}

protocol NoteViewControllable: ViewControllable {}

final class NoteRouter: ViewableRouter<NoteInteractable,
                        NoteViewControllable>,
                          NoteRouting {
  override init(
    interactor: NoteInteractable,
    viewController: NoteViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    
    interactor.router = self
  }
}
