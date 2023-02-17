//
//  MainBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Main
import ModernRIBs

public protocol MainDependency: Dependency {}

final class MainComponent: Component<MainDependency> {}

// MARK: - Builder

public final class MainBuilder: Builder<MainDependency>,
                         MainBuildable {
  public override init(dependency: MainDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: MainListener) -> ViewableRouting {
    let _ = MainComponent(dependency: dependency)
    let viewController = MainViewController()
    let interactor = MainInteractor(presenter: viewController)
    interactor.listener = listener
    return MainRouter(interactor: interactor, viewController: viewController)
  }
}
