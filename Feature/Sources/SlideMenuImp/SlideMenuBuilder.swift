//
//  SlideMenuBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import Repository
import SlideMenu

public protocol SlideMenuDependency: Dependency {
  var noteRepository: NoteRepository { get }
}

final class SlideMenuComponent: Component<SlideMenuDependency>,
                                SlideMenuInteractorDependency {
  var noteRepository: NoteRepository {
    dependency.noteRepository
  }
}

// MARK: - Builder

public final class SlideMenuBuilder: Builder<SlideMenuDependency>,
                                     SlideMenuBuildable {
  public override init(dependency: SlideMenuDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: SlideMenuListener) -> ViewableRouting {
    let component = SlideMenuComponent(dependency: dependency)
    let viewController = SlideMenuViewController()
    let interactor = SlideMenuInteractor(
      presenter: viewController,
      dependency: component
    )
    interactor.listener = listener
    return SlideMenuRouter(interactor: interactor, viewController: viewController)
  }
}
