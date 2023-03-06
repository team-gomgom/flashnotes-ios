//
//  Environment.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/06.
//

import Foundation

enum Environment {
  static let serverBaseURL: String = plist(.serverBaseURL)
}

// MARK: - Private

extension Environment {
  private enum PlistKeys: String {
    case serverBaseURL = "ServerBaseURL"
  }

  private static func plist<T>(_ key: PlistKeys) -> T {
    guard let value = infoDictionary[key.rawValue] else {
      fatalError("\(key) not set in plist")
    }

    guard let value = value as? T else {
      fatalError("value of \(key) in plist failed to typecast into \(type(of: T.self))")
    }

    return value
  }

  private static let infoDictionary: [String: Any] = {
    guard let infoDictionary = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return infoDictionary
  }()
}
