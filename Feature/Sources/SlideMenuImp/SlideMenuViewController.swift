//
//  SlideMenuViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import ModernRIBs
import UIKit

protocol SlideMenuPresentableListener: AnyObject {}

final class SlideMenuViewController: UIViewController,
                                     SlideMenuPresentable,
                                     SlideMenuViewControllable {
  weak var listener: SlideMenuPresentableListener?
}
