//
//  NoteInteractor.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note
import RIBsUtil

protocol NoteRouting: ViewableRouting {
  func attachPage()
  func detachPage()
}

protocol NotePresentable: Presentable {
  var listener: NotePresentableListener? { get set }
}

final class NoteInteractor: PresentableInteractor<NotePresentable> {
  weak var router: NoteRouting?
  weak var listener: NoteListener?

  let navigationDelegateProxy = NaviagationControllerDelegateProxy()

  override init(presenter: NotePresentable) {
    super.init(presenter: presenter)

    presenter.listener = self
    navigationDelegateProxy.delegate = self
  }
}

// MARK: - NotePresentableListener

extension NoteInteractor: NotePresentableListener {
  func didTapTrainingButton() {}

  func didTapAddNote() {
    router?.attachPage()
  }

  func didTapDeleteNote() {}
}

// MARK: - AdaptivePresentationControllerDelegate

extension NoteInteractor: NaviagationControllerDelegate {
  func childViewControllerDidPop() {
    router?.detachPage()
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
}
