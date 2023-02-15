//
//  SlideMenuBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import SlideMenu

public protocol SlideMenuDependency: Dependency {}

final class SlideMenuComponent: Component<SlideMenuDependency> {}

// MARK: - Builder

public final class SlideMenuBuilder: Builder<SlideMenuDependency>,
                                     SlideMenuBuildable {
  public override init(dependency: SlideMenuDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: SlideMenuListener) -> ViewableRouting {
    let _ = SlideMenuComponent(dependency: dependency)
    let viewController = SlideMenuViewController()
    let interactor = SlideMenuInteractor(presenter: viewController)
    interactor.listener = listener
    return SlideMenuRouter(interactor: interactor, viewController: viewController)
  }
}
