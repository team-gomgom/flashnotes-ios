//
//  SlideMenuInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import Combine
import CombineSchedulers
import Foundation
import ModernRIBs
import Repository
import SlideMenu

protocol SlideMenuRouting: ViewableRouting {}

protocol SlideMenuPresentable: Presentable {
  var listener: SlideMenuPresentableListener? { get set }

  func update(with viewModels: [NoteListCellViewModel])
}

protocol SlideMenuInteractorDependency {
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
    dependency.noteRepository.notes
      .receive(on: dependency.mainQueue)
      .sink { [weak self] notes in
        let viewModels = notes.map(NoteListCellViewModel.init)
        self?.presenter.update(with: viewModels)
      }.store(in: &cancellables)

    dependency.noteRepository.getNotes()
      .retry(2)
      .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
      .store(in: &cancellables)
  }
}

// MARK: - SlideMenuPresentableListener

extension SlideMenuInteractor: SlideMenuPresentableListener {
  func didTapAddNoteButton() {
    listener?.didTapAddNoteButton()
  }

  func didTapSettingButton() {

  }

  func didSelectItem(at index: Int) {

  }
}
