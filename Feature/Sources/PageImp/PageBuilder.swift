//
//  PageBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs
import Page

public protocol PageDependency: Dependency {}

final class PageComponent: Component<PageDependency> {}

// MARK: - Builder

public final class PageBuilder: Builder<PageDependency>, PageBuildable {
  public override init(dependency: PageDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: PageListener) -> ViewableRouting {
    let component = PageComponent(dependency: dependency)
    let viewController = PageViewController()
    let interactor = PageInteractor(presenter: viewController)
    interactor.listener = listener
    return PageRouter(interactor: interactor, viewController: viewController)
  }
}
