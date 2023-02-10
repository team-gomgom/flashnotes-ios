//
//  AppRootViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import ModernRIBs
import UIKit

protocol AppRootPresentableListener: AnyObject {}

final class AppRootViewController: UIViewController,
                                   AppRootPresentable,
                                   AppRootViewControllable {
  weak var listener: AppRootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
  }
}
