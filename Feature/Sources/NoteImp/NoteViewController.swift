//
//  NoteViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs
import UIKit

protocol NotePresentableListener: AnyObject {}

final class NoteViewController: UIViewController,
                                NotePresentable,
                                NoteViewControllable {
  weak var listener: NotePresentableListener?
}
