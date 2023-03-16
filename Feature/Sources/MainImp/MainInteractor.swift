//
//  MainInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Combine
import CombineSchedulers
import Foundation
import Main
import ModernRIBs
import Note
import Repository
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

protocol MainInteractorDependency {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var noteRepository: NoteRepository { get }
}

final class MainInteractor: PresentableInteractor<MainPresentable>,
                            MainInteractable {
  weak var router: MainRouting?
  weak var listener: MainListener?

  private let dependency: MainInteractorDependency
  private var cancellables = Set<AnyCancellable>()
  
  init(
    presenter: MainPresentable,
    dependency: MainInteractorDependency
  ) {
    self.dependency = dependency
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
    dependency.noteRepository.addNote(title: title)
      .sink(
        receiveCompletion: { completion in
          // error handling
        },
        receiveValue: { _ in }
      ).store(in: &cancellables)
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
