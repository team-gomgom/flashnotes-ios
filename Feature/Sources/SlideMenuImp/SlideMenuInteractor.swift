//
//  SlideMenuInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import SlideMenu

protocol SlideMenuRouting: ViewableRouting {}

protocol SlideMenuPresentable: Presentable {
  var listener: SlideMenuPresentableListener? { get set }
}

final class SlideMenuInteractor: PresentableInteractor<SlideMenuPresentable>,
                                 SlideMenuInteractable,
                                 SlideMenuPresentableListener {
  weak var router: SlideMenuRouting?
  weak var listener: SlideMenuListener?

  override init(presenter: SlideMenuPresentable) {
    super.init(presenter: presenter)

    presenter.listener = self
  }
}
