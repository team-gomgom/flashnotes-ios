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
import Network
import Repository

public protocol LoggedInDependency: Dependency {
  var baseURL: String { get }
  var network: Network { get }
  var loggedInViewController: ViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency>,
                               MainDependency {
  fileprivate var loggedInViewController: ViewControllable {
    return dependency.loggedInViewController
  }
  var noteRepository: NoteRepository

  init(
    dependency: LoggedInDependency,
    token: String
  ) {
    self.noteRepository = NoteRepositoryImp(
      network: dependency.network,
      baseURL: dependency.baseURL,
      authorization: token
    )
    super.init(dependency: dependency)
  }
}

public final class LoggedInBuilder: Builder<LoggedInDependency>,
                                    LoggedInBuildable {
  public override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: LoggedInListener, token: String) -> Routing {
    let component = LoggedInComponent(dependency: dependency, token: token)
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
