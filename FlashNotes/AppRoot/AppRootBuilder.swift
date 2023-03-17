//
//  AppRootBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import CombineSchedulers
import Foundation
import LoggedIn
import LoggedInImp
import ModernRIBs
import Network
import NetworkImp

protocol AppRootDependency: Dependency {}

final class AppRootComponent: Component<AppRootDependency>,
                              LoggedInDependency {
  var mainQueue: AnySchedulerOf<DispatchQueue> { .main }
  var baseURL: String
  var network: Network
  var loggedInViewController: ViewControllable { rootViewController }

  private let rootViewController: ViewControllable

  init(dependency: AppRootDependency, rootViewController: ViewControllable) {
    self.rootViewController = rootViewController
    #if DEBUG
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    MockURLProtocol.setup(baseURL: Environment.serverBaseURL)
    #else
    let configuration = URLSessionConfiguration.default
    #endif
    self.baseURL = Environment.serverBaseURL
    self.network = NetworkImp(session: URLSession(configuration: configuration))
    super.init(dependency: dependency)
  }
}

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
    let component = AppRootComponent(dependency: dependency, rootViewController: viewController)
    let loggedInBuildable = LoggedInBuilder(dependency: component)
    return AppRootRouter(
      interactor: interactor,
      viewController: viewController,
      loggedInBuildable: loggedInBuildable
    )
  }
}
