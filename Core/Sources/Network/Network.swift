//
//  Network.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Combine
import Foundation

public protocol Network {
  func request<R: Decodable, E: RequestResponsable>(with endpoint: E) -> AnyPublisher<Response<R>, Error> where E.Response == R
}

public struct Response<T: Decodable> {
  public let output: T
  public let statusCode: Int

  public init(output: T, statusCode: Int) {
    self.output = output
    self.statusCode = statusCode
  }
}
