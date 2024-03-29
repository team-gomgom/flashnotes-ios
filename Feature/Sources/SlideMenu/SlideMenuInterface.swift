//
//  SlideMenuInterface.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import Entity
import ModernRIBs

public protocol SlideMenuBuildable: Buildable {
    func build(withListener listener: SlideMenuListener) -> ViewableRouting
}

public protocol SlideMenuListener: AnyObject {
  func didSelectNote(_ note: Note)
  func didTapAddNoteButton()
}
