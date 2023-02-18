//
//  LoggedInInterface.swift
//  
//
//  Created by 정동천 on 2023/02/18.
//

import ModernRIBs

public protocol LoggedInBuildable: Buildable {
  func build(withListener listener: LoggedInListener) -> Routing
}

public protocol LoggedInListener: AnyObject {}
