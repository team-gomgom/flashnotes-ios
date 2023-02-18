//
//  LoggedInBuilder.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/18.
//

import LoggedIn
import Main
import MainImp
import ModernRIBs

public protocol LoggedInDependency: Dependency {
  var loggedInViewController: ViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency>,
                               MainDependency {
  fileprivate var loggedInViewController: ViewControllable {
    return dependency.loggedInViewController
  }
}

public final class LoggedInBuilder: Builder<LoggedInDependency>,
                                    LoggedInBuildable {
  public override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: LoggedInListener) -> Routing {
    let component = LoggedInComponent(dependency: dependency)
    let interactor = LoggedInInteractor()
    interactor.listener = listener
    let mainBuildable = MainBuilder(dependency: component)
    return LoggedInRouter(
      interactor: interactor,
      viewController: component.loggedInViewController,
      mainBuildable: mainBuildable
    )
  }
}
