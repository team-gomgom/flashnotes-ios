//
//  NetworkError.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Foundation

public enum NetworkError: LocalizedError {
  case invalidHttpsStatusCode(Int)
  case decodeFailed

  public var errorDescription: String? {
    switch self {
    case .invalidHttpsStatusCode(let code):
      return "status code가 \(code)입니다."
    case .decodeFailed:
      return "decode에 실패하였습니다."
    }
  }
}
