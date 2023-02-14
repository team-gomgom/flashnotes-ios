//
//  Network.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Combine
import Foundation

public protocol Network {
  func request<R: Decodable, E: RequestResponsable>(with endpoint: E) -> AnyPublisher<R, Error> where E.Response == R
}
