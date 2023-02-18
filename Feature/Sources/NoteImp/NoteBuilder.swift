//
//  NoteBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note

public protocol NoteDependency: Dependency {}

final class NoteComponent: Component<NoteDependency> {}

// MARK: - Builder

public final class NoteBuilder: Builder<NoteDependency>,
                                NoteBuildable {
  public override init(dependency: NoteDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: NoteListener) -> ViewableRouting {
    let _ = NoteComponent(dependency: dependency)
    let viewController = NoteViewController()
    let interactor = NoteInteractor(presenter: viewController)
    interactor.listener = listener
    return NoteRouter(interactor: interactor, viewController: viewController)
  }
}
