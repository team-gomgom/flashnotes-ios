//
//  SlideMenuInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import Combine
import CombineSchedulers
import CombineUtil
import Entity
import Foundation
import ModernRIBs
import Repository
import SlideMenu

protocol SlideMenuRouting: ViewableRouting {}

protocol SlideMenuPresentable: Presentable {
  var listener: SlideMenuPresentableListener? { get set }

  func update(with viewModels: [NoteListCellViewModel])
  func updateSelectedRow(at row: Int)
}

protocol SlideMenuInteractorDependency {
  var selectedNote: ReadOnlyCurrentValuePublisher<Note?> { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var noteRepository: NoteRepository { get }
}

final class SlideMenuInteractor: PresentableInteractor<SlideMenuPresentable>,
                                 SlideMenuInteractable {
  weak var router: SlideMenuRouting?
  weak var listener: SlideMenuListener?

  private let dependency: SlideMenuInteractorDependency
  private var cancellables = Set<AnyCancellable>()

  init(
    presenter: SlideMenuPresentable,
    dependency: SlideMenuInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)

    presenter.listener = self

    bind()
    getNotes()
  }
}

// MARK: - SlideMenuPresentableListener

extension SlideMenuInteractor: SlideMenuPresentableListener {

  func didTapAddNoteButton() {
    listener?.didTapAddNoteButton()
  }

  func didTapSettingButton() {

  }

  func didSelectItem(at row: Int) {
    let note = dependency.noteRepository.notes.value[row]
    listener?.didSelectNote(note)
  }
}

// MARK: - Private

private extension SlideMenuInteractor {

  func bind() {
    dependency.noteRepository.notes
      .receive(on: dependency.mainQueue)
      .sink { [weak self] notes in
        let viewModels = notes.map(NoteListCellViewModel.init)
        self?.presenter.update(with: viewModels)
      }.store(in: &cancellables)

    dependency.selectedNote.compactMap { $0 }
      .receive(on: dependency.mainQueue)
      .sink { [weak self] note in
        if let row = self?.dependency.noteRepository.notes.value.lastIndex(of: note) {
          self?.presenter.updateSelectedRow(at: row)
        }
      }.store(in: &cancellables)
  }

  func getNotes() {
    dependency.noteRepository.getNotes().retry(2)
      .receive(on: dependency.mainQueue)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] notes in
          if let note = notes.first {
            self?.listener?.didSelectNote(note)
          }
        }
      ).store(in: &cancellables)
  }
}

