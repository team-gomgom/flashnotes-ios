//
//  AddPageInterface.swift
//  
//
//  Created by 정동천 on 2023/03/18.
//

import ModernRIBs

public protocol AddPageBuildable: Buildable {
  func build(withListener listener: AddPageListener) -> ViewableRouting
}

public protocol AddPageListener: AnyObject {}
