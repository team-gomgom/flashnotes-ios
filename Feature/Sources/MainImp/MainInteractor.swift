//
//  MainInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Combine
import CombineUtil
import CombineSchedulers
import Entity
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
  func collapseSlideMenu()
}

protocol MainInteractorDependency {
  var _selectedNote: CurrentValuePublisher<Note?> { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var noteRepository: NoteRepository { get }
  var pageRepository: PageRepository { get }
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

    bind()
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
      .receive(on: dependency.mainQueue)
      .sink(
        receiveCompletion: { completion in
          // error handling
        },
        receiveValue: { [weak self] note in
          self?.dependency._selectedNote.send(note)
          self?.presenter.collapseSlideMenu()
        }
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

  func didSelectNote(_ note: Note) {
    dependency._selectedNote.send(note)
    dependency.pageRepository.clearPages()
    presenter.collapseSlideMenu()
  }

  func didTapAddNoteButton() {
    presenter.presentNoteCreation()
  }
}

// MARK: - Private

private extension MainInteractor {

  func bind() {
    dependency.noteRepository.notes
      .filter(\.isEmpty)
      .sink { [weak self] _ in
        self?.dependency._selectedNote.send(nil)
      }.store(in: &cancellables)
  }
}
