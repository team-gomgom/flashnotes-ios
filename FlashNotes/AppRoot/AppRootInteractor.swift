//
//  AppRootInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import ModernRIBs

protocol AppRootRouting: ViewableRouting {
  func routeToLoggedIn(token: String)
}

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>,
                               AppRootInteractable,
                               AppRootPresentableListener {
  weak var router: AppRootRouting?
  
  override init(presenter: AppRootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()

    // check loggedIn or loggedOut
    let token = ""
    router?.routeToLoggedIn(token: token)
  }
  
  override func willResignActive() {
    super.willResignActive()
  }
}
