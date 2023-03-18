//
//  AddPageBuilder.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import ModernRIBs
import Page

public protocol AddPageDependency: Dependency {}

final class AddPageComponent: Component<AddPageDependency> {}

// MARK: - Builder

public final class AddPageBuilder: Builder<AddPageDependency>, AddPageBuildable {

  public override init(dependency: AddPageDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: AddPageListener) -> ViewableRouting {
    let component = AddPageComponent(dependency: dependency)
    let viewController = AddPageViewController()
    let interactor = AddPageInteractor(presenter: viewController)
    interactor.listener = listener
    return AddPageRouter(interactor: interactor, viewController: viewController)
  }
}
