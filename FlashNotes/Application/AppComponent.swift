//
//  AppComponent.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import Foundation
import ModernRIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
