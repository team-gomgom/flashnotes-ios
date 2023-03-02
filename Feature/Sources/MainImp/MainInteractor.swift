//
//  MainInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs
import Note
import SlideMenu
import SlideMenuImp

protocol MainRouting: ViewableRouting {
  func attachSlideMenu()
  func attachNote()
  func detachNote()
}

protocol MainPresentable: Presentable {
  var listener: MainPresentableListener? { get set }

  func updateGestureEnabledState(_ state: Bool)
  func presentNoteCreation()
}

final class MainInteractor: PresentableInteractor<MainPresentable>,
                            MainInteractable {
  weak var router: MainRouting?
  weak var listener: MainListener?
  
  override init(presenter: MainPresentable) {
    super.init(presenter: presenter)

    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()

    router?.attachSlideMenu()
    router?.attachNote()
  }
}

// MARK: - MainPresentableListener

extension MainInteractor: MainPresentableListener {
  func createNote(title: String) {
    
  }
}

// MARK: - NoteListener

extension MainInteractor: NoteListener {
  func navigationViewControllerDidPush() {
    presenter.updateGestureEnabledState(false)
  }

  func navigationViewControllerDidPop() {
    presenter.updateGestureEnabledState(true)
  }
}

// MARK: - SlideMenuListener

extension MainInteractor: SlideMenuListener {
  func didTapAddNoteButton() {
    presenter.presentNoteCreation()
  }
}
