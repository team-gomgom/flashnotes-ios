//
//  AddPageBuilder.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import CombineUtil
import Entity
import ModernRIBs
import Page

public protocol AddPageDependency: Dependency {
  var note: ReadOnlyCurrentValuePublisher<Note?> { get }
}

final class AddPageComponent: Component<AddPageDependency>,
                              AddPageInteractorDependency {

  var note: ReadOnlyCurrentValuePublisher<Note?> { dependency.note }
}

// MARK: - Builder

public final class AddPageBuilder: Builder<AddPageDependency>, AddPageBuildable {

  public override init(dependency: AddPageDependency) {
    super.init(dependency: dependency)
  }

  public func build(withListener listener: AddPageListener) -> ViewableRouting {
    let component = AddPageComponent(dependency: dependency)
    let viewController = AddPageViewController()
    let interactor = AddPageInteractor(presenter: viewController, dependency: component)
    interactor.listener = listener
    return AddPageRouter(interactor: interactor, viewController: viewController)
  }
}
