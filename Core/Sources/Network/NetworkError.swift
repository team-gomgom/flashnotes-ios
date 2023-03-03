//
//  NetworkError.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Foundation

public enum NetworkError: LocalizedError {
  case serverSideIssue(String?)
  case invalidHttpsStatusCode(Int)
  case decodeFailed
  case urlComponentFailed
  case emptyMappingResult

  public var errorDescription: String? {
    switch self {
    case .serverSideIssue(let message):
      return message
    case .invalidHttpsStatusCode(let code):
      return "status code가 \(code)입니다."
    case .decodeFailed:
      return "decode에 실패하였습니다."
    case .urlComponentFailed:
      return "urlComponent에 실패하였습니다."
    case .emptyMappingResult:
      return "변환된 값이 비어있습니다."
    }
  }
}
