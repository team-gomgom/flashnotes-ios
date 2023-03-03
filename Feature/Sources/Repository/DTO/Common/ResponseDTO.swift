//
//  ResponseDTO.swift
//  
//
//  Created by 정동천 on 2023/03/03.
//

import Foundation
import Network

struct ResponseDTO<T: Decodable>: Decodable {
  private let data: [T]?
  private let message: String?
}

extension ResponseDTO {
  func validate(statusCode: Int) throws {
    if (500...599).contains(statusCode) {
      throw NetworkError.serverSideIssue(message)
    }

    guard (200...299).contains(statusCode) else {
      throw NetworkError.invalidHttpsStatusCode(statusCode)
    }
  }
  
  func just() throws -> T {
    guard let value = data?.first else {
      throw NetworkError.emptyMappingResult
    }
    return value
  }

  func values() throws -> [T] {
    guard let values = data else {
      throw NetworkError.emptyMappingResult
    }
    return values
  }
}
