//
//  NavigationControllerable.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import UIKit

public final class NavigationControllable: ViewControllable {
  public var uiviewController: UIViewController { navigationController }
  public let navigationController: UINavigationController

  public init(rootViewControllable: ViewControllable) {
    let rootViewController = rootViewControllable.uiviewController
    let navigationController = UINavigationController(rootViewController: rootViewController)
    self.navigationController = navigationController
  }
}
