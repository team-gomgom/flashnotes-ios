//
//  SceneDelegate.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/10.
//

import ModernRIBs
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  private var launchRouter: LaunchRouting?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    self.launchRouter = AppRootBuilder(dependency: AppComponent()).build()
    launchRouter?.launch(from: window)
  }
}
