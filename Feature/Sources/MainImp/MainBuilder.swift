//
//  MainBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs
import Note
import NoteImp
import SlideMenu
import SlideMenuImp

public protocol MainDependency: Dependency {}

final class MainComponent: Component<MainDependency>, SlideMenuDependency, NoteDependency {}

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
