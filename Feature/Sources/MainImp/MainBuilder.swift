//
//  MainBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import CombineSchedulers
import Foundation
import Main
import ModernRIBs
import Note
import NoteImp
import Repository
import SlideMenu
import SlideMenuImp

public protocol MainDependency: Dependency {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var noteRepository: NoteRepository { get }
}

final class MainComponent: Component<MainDependency>,
                           SlideMenuDependency,
                           NoteDependency{
  var mainQueue: AnySchedulerOf<DispatchQueue> { dependency.mainQueue }
  var noteRepository: NoteRepository { dependency.noteRepository }
}

// MARK: - Builder

public final class MainBuilder: Builder<MainDependency> {}

extension MainBuilder: MainBuildable {
  public func build(withListener listener: MainListener) -> ViewableRouting {
    let component = MainComponent(dependency: dependency)
    let viewController = MainViewController()
    let slideMenuBuildable = SlideMenuBuilder(dependency: component)
    let noteBuildable = NoteBuilder(dependency: component)
    let interactor = MainInteractor(presenter: viewController)
    interactor.listener = listener

    return MainRouter(
      interactor: interactor,
      viewController: viewController,
      slideMenuBuildable: slideMenuBuildable,
      noteBuildable: noteBuildable
    )
  }
}
