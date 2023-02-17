//
//  MainInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs

protocol MainRouting: ViewableRouting {}

protocol MainPresentable: Presentable {
  var listener: MainPresentableListener? { get set }
}



final class MainInteractor: PresentableInteractor<MainPresentable>,
                            MainInteractable,
                            MainPresentableListener {
  weak var router: MainRouting?
  weak var listener: MainListener?
  
  override init(presenter: MainPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}
