//
//  PageInterface.swift
//  
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs

public protocol PageBuildable: Buildable {
  func build(withListener listener: PageListener) -> ViewableRouting
}

public protocol PageListener: AnyObject {}
