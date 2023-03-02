//
//  NoteInterface.swift
//  
//
//  Created by 정동천 on 2023/02/16.
//

import ModernRIBs

public protocol NoteBuildable: Buildable {
  func build(withListener listener: NoteListener) -> ViewableRouting
}

public protocol NoteListener: AnyObject {
  func navigationViewControllerDidPush()
  func navigationViewControllerDidPop()
}
