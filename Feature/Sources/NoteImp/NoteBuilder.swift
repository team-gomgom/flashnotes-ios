//
//  NoteBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import Note
import Page
import PageImp

public protocol NoteDependency: Dependency {}

final class NoteComponent: Component<NoteDependency>, PageDependency {}

// MARK: - Builder

public final class NoteBuilder: Builder<NoteDependency>,
                                NoteBuildable {
  public override init(dependency: NoteDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: NoteListener) -> ViewableRouting {
    let component = NoteComponent(dependency: dependency)
    let viewController = NoteViewController()
    let interactor = NoteInteractor(presenter: viewController)
    interactor.listener = listener
    let pageBuilder = PageBuilder(dependency: component)
    return NoteRouter(
      interactor: interactor,
      viewController: viewController,
      pageBuildable: pageBuilder
    )
  }
}
