//
//  ViewControllable++.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import UIKit

public enum ModalPresentationStyle {
  case fullScreen
  case overFullScreen

  public var uiModalPresentationStyle: UIModalPresentationStyle {
    switch self {
    case .fullScreen:
      return .fullScreen
    case .overFullScreen:
      return .overFullScreen
    }
  }
}

// MARK: - ViewControllable + Utils

public extension ViewControllable {
  var topViewControllable: ViewControllable {
    var top: ViewControllable = self

    while let presented = top.uiviewController.presentedViewController as? ViewControllable {
      top = presented
    }

    return top
  }

  func present(
    _ viewControllable: ViewControllable,
    modalPresentationStyle: ModalPresentationStyle? = nil,
    animated: Bool,
    completion: (() -> Void)? = nil
  ) {
    if let modalPresentationStyle = modalPresentationStyle?.uiModalPresentationStyle {
      viewControllable.uiviewController.modalPresentationStyle = modalPresentationStyle
    }

    uiviewController.present(
      viewControllable.uiviewController,
      animated: animated,
      completion: completion
    )
  }

  func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
    uiviewController.dismiss(animated: animated, completion: completion)
  }

  func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
    let viewController = viewControllable.uiviewController
    navigationController?.pushViewController(viewController, animated: animated)
  }

  func popViewController(animated: Bool) {
    navigationController?.popViewController(animated: animated)
  }

  func popToRoot(animated: Bool) {
    navigationController?.popToRootViewController(animated: animated)
  }

  func setViewControllers(_ viewControllerables: [ViewControllable], animated: Bool) {
    let viewControllers = viewControllerables.map(\.uiviewController)
    navigationController?.setViewControllers(viewControllers, animated: animated)
  }
}

// MARK: - Private

private extension ViewControllable {
  var navigationController: UINavigationController? {
    if let navigationController = uiviewController as? UINavigationController {
      return navigationController
    }
    return uiviewController.navigationController
  }
}
