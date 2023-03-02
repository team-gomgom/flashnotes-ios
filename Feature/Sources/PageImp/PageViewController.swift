//
//  PageViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs
import UIKit

protocol PagePresentableListener: AnyObject {}

final class PageViewController: UIViewController,
                                PagePresentable,
                                PageViewControllable {
  weak var listener: PagePresentableListener?
}
