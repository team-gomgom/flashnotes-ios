//
//  NoteInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import Combine
import CombineSchedulers
import CombineUtil
import Entity
import Foundation
import ModernRIBs
import Note
import Repository
import RIBsUtil

protocol NoteRouting: ViewableRouting {
  func attachPage()
  func detachPage()
  func attachAddPage()
  func detachAddPage()
}

protocol NotePresentable: Presentable {
  var listener: NotePresentableListener? { get set }

  func update(with viewModels: [PageListCellViewModel])
  func updateTitle(_ title: String?)
}

protocol NoteInteractorDependency {
  var note: ReadOnlyCurrentValuePublisher<Note?> { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var pageRepository: PageRepository { get }
}

final class NoteInteractor: PresentableInteractor<NotePresentable> {
  
  weak var router: NoteRouting?
  weak var listener: NoteListener?

  let navigationDelegateProxy = NaviagationControllerDelegateProxy()

  private let dependency: NoteInteractorDependency
  private var cancellables = Set<AnyCancellable>()

  init(
    presenter: NotePresentable,
    dependency: NoteInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)

    presenter.listener = self
    navigationDelegateProxy.delegate = self

    bind()
    getPages(noteID: "")
  }
}

// MARK: - NotePresentableListener

extension NoteInteractor: NotePresentableListener {

  func didTapTrainingButton() {}

  func didTapAddNote() {
    router?.attachAddPage()
  }

  func didTapDeleteNote() {}
}

// MARK: - AdaptivePresentationControllerDelegate

extension NoteInteractor: NaviagationControllerDelegate {

  func childViewControllerDidPop() {
    router?.detachAddPage()
  }
}

// MARK: - NoteInteractable

extension NoteInteractor: NoteInteractable {

  func navigationControllerDidPush() {
    listener?.navigationViewControllerDidPush()
  }

  func navigationControllerDidPop() {
    listener?.navigationViewControllerDidPop()
  }

  func addPageInteractorDidAddPage() {
    router?.detachAddPage()
  }
}

// MARK: - Private

private extension NoteInteractor {

  func bind() {
    dependency.pageRepository.pages
      .receive(on: dependency.mainQueue)
      .sink { [weak self] pages in
        let viewModels = pages.map(PageListCellViewModel.init)
        self?.presenter.update(with: viewModels)
      }.store(in: &cancellables)

    dependency.note
      .receive(on: dependency.mainQueue)
      .sink { [weak self] note in
        self?.presenter.updateTitle(note?.title)
        self?.getPages(noteID: note?.id)
      }.store(in: &cancellables)
  }

  func getPages(noteID: String?) {
    dependency.pageRepository.clearPages()
    if let noteID = noteID {
      dependency.pageRepository.getPages(noteID: noteID)
        .receive(on: dependency.mainQueue)
        .sink(
          receiveCompletion: { completion in
            // error handling
          },
          receiveValue: { _ in }
        ).store(in: &cancellables)
    }
  }
}
