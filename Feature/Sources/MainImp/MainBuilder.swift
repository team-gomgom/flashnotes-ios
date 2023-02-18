//
//  MainBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs
import SlideMenu
import SlideMenuImp

public protocol MainDependency: Dependency {}

final class MainComponent: Component<MainDependency>, SlideMenuDependency {}

// MARK: - Builder

public final class MainBuilder: Builder<MainDependency>,
                                MainBuildable {
  public override init(dependency: MainDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: MainListener) -> ViewableRouting {
    let component = MainComponent(dependency: dependency)
    let viewController = MainViewController()
    let slideMenuBuildable = SlideMenuBuilder(dependency: component)
    let interactor = MainInteractor(presenter: viewController)
    interactor.listener = listener
    return MainRouter(
      interactor: interactor,
      viewController: viewController,
      slideMenuBuildable: slideMenuBuildable
    )
  }
}
