//
//  AddPageInteractor.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import CombineUtil
import Entity
import ModernRIBs
import Page

protocol AddPageRouting: ViewableRouting {}

protocol AddPagePresentable: Presentable {
  var listener: AddPagePresentableListener? { get set }

  func updateTitle(_ title: String?)
}

protocol AddPageInteractorDependency {
  var note: ReadOnlyCurrentValuePublisher<Note?> { get }
}

final class AddPageInteractor: PresentableInteractor<AddPagePresentable>,
                               AddPageInteractable,
                               AddPagePresentableListener {

  weak var router: AddPageRouting?
  weak var listener: AddPageListener?

  private let dependency: AddPageInteractorDependency

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
