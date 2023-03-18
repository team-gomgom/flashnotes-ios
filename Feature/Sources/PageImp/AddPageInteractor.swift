//
//  AddPageInteractor.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import ModernRIBs
import Page

protocol AddPageRouting: ViewableRouting {}

protocol AddPagePresentable: Presentable {
  var listener: AddPagePresentableListener? { get set }
}

final class AddPageInteractor: PresentableInteractor<AddPagePresentable>,
                               AddPageInteractable,
                               AddPagePresentableListener {

  weak var router: AddPageRouting?
  weak var listener: AddPageListener?

  override init(presenter: AddPagePresentable) {
    super.init(presenter: presenter)

    presenter.listener = self
  }
}
