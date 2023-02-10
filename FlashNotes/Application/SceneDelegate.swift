//
//  SceneDelegate.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }
}
