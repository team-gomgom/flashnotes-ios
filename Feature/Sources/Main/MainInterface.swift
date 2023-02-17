//
//  MainInterface.swift
//  
//
//  Created by 정동천 on 2023/02/17.
//

import ModernRIBs

public protocol MainBuildable: Buildable {
  func build(withListener listener: MainListener) -> ViewableRouting
}

public protocol MainListener: AnyObject {}
