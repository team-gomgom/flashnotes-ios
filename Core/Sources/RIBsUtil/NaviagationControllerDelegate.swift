//
//  NaviagationControllerDelegate.swift
//  
//
//  Created by 정동천 on 2023/03/02.
//

import UIKit

public protocol NaviagationControllerDelegate: AnyObject {
  func childViewControllerDidPop()
}

public final class NaviagationControllerDelegateProxy: NSObject {
  public weak var delegate: NaviagationControllerDelegate?

  private weak var parentViewController: UIViewController?

  public func startObserving(parent parentViewController: UIViewController) {
    self.parentViewController = parentViewController
  }
}

// MARK: - UINavigationControllerDelegate

extension NaviagationControllerDelegateProxy: UINavigationControllerDelegate {
  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    if let parent = parentViewController, viewController === parent {
      delegate?.childViewControllerDidPop()
      parentViewController = nil
    }
  }
}
