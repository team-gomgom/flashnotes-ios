//
//  PageInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs
import Page

protocol PageRouting: ViewableRouting {}

protocol PagePresentable: Presentable {
  var listener: PagePresentableListener? { get set }
}

final class PageInteractor: PresentableInteractor<PagePresentable>,
                            PageInteractable,
                            PagePresentableListener {
  weak var router: PageRouting?
  weak var listener: PageListener?

  override init(presenter: PagePresentable) {
    super.init(presenter: presenter)
    
    presenter.listener = self
  }
}
