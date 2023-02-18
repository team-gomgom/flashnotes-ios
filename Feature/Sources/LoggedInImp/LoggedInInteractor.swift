//
//  LoggedInInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/18.
//

import LoggedIn
import ModernRIBs

protocol LoggedInRouting: Routing {
  func cleanupViews()
}



final class LoggedInInteractor: Interactor, LoggedInInteractable {
  weak var router: LoggedInRouting?
  weak var listener: LoggedInListener?

  override init() {}

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()

    router?.cleanupViews()
  }
}
