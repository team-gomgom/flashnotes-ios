//
//  MainViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import ModernRIBs
import UIKit

protocol MainPresentableListener: AnyObject {}

final class MainViewController: UIViewController,
                                MainPresentable,
                                MainViewControllable {
  weak var listener: MainPresentableListener?
}
