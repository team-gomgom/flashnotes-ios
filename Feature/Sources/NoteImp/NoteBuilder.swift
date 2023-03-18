//
//  NoteBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import CombineSchedulers
import CombineUtil
import Entity
import Foundation
import ModernRIBs
import Note
import Page
import PageImp
import Repository

public protocol NoteDependency: Dependency {
  var selectedNote: ReadOnlyCurrentValuePublisher<Note?> { get }
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var pageRepository: PageRepository { get }
}

final class NoteComponent: Component<NoteDependency>,
                           PageDependency,
                           NoteInteractorDependency {

  var note: ReadOnlyCurrentValuePublisher<Note?> { dependency.selectedNote }
  var mainQueue: AnySchedulerOf<DispatchQueue> { dependency.mainQueue }
  var pageRepository: PageRepository { dependency.pageRepository }
}

// MARK: - Builder

public final class NoteBuilder: Builder<NoteDependency>,
                                NoteBuildable {
  
  public override init(dependency: NoteDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: NoteListener) -> ViewableRouting {
    let component = NoteComponent(dependency: dependency)
    let viewController = NoteViewController()
    let interactor = NoteInteractor(presenter: viewController, dependency: component)
    interactor.listener = listener
    let pageBuilder = PageBuilder(dependency: component)
    return NoteRouter(
      interactor: interactor,
      viewController: viewController,
      pageBuildable: pageBuilder
    )
  }
}
