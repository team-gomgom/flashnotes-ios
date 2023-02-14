//
//  AppRootBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import ModernRIBs

protocol AppRootDependency: Dependency {}

final class AppRootComponent: Component<AppRootDependency> {}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {
  override init(dependency: AppRootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
    let viewController = AppRootViewController()
    let interactor = AppRootInteractor(presenter: viewController)
    return AppRootRouter(interactor: interactor, viewController: viewController)
  }
}
