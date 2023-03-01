//
//  NoteInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note

protocol NoteRouting: ViewableRouting {}

protocol NotePresentable: Presentable {
  var listener: NotePresentableListener? { get set }
}

final class NoteInteractor: PresentableInteractor<NotePresentable>,
                            NoteInteractable {
  weak var router: NoteRouting?
  weak var listener: NoteListener?

  override init(presenter: NotePresentable) {
    super.init(presenter: presenter)

    presenter.listener = self
  }
}

// MARK: - NotePresentableListener

extension NoteInteractor: NotePresentableListener {
  func didTapTrainingButton() {}
  func didTapMoreButton() {}
}
