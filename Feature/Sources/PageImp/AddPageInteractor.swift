//
//  AddPageInteractor.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import Combine
import CombineSchedulers
import CombineUtil
import Entity
import Foundation
import ModernRIBs
import Page
import Repository

protocol AddPageRouting: ViewableRouting {}

protocol AddPagePresentable: Presentable {
  var listener: AddPagePresentableListener? { get set }

  func updateTitle(_ title: String?)
}

protocol AddPageInteractorDependency {
  var note: ReadOnlyCurrentValuePublisher<Note?> { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var pageRepository: PageRepository { get }
}

final class AddPageInteractor: PresentableInteractor<AddPagePresentable>,
                               AddPageInteractable {

  weak var router: AddPageRouting?
  weak var listener: AddPageListener?

  private let dependency: AddPageInteractorDependency
  private var cancellables = Set<AnyCancellable>()

  init(
    presenter: AddPagePresentable,
    dependency: AddPageInteractorDependency
  ) {
    self.dependency = dependency
    super.init(presenter: presenter)

    presenter.listener = self

    presenter.updateTitle(dependency.note.value?.title)
  }
}

// MARK: - AddPagePresentableListener

extension AddPageInteractor: AddPagePresentableListener {

  func doneButtonDidTap(withQuestion question: String, answer: String) {
    if let noteID = dependency.note.value?.id {
      dependency.pageRepository.addPage(noteID: noteID, question: question, answer: answer)
        .receive(on: dependency.mainQueue)
        .sink(
          receiveCompletion: { completion in
            // error handling
          },
          receiveValue: { [weak self] _ in
            self?.listener?.addPageInteractorDidAddPage()
          }
        ).store(in: &cancellables)
    }
  }
}
