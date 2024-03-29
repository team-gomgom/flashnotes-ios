//
//  NetworkImp.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Combine
import Foundation
import Network

public final class NetworkImp: Network {

  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }

  public func request<R: Decodable, E: RequestResponsable>(
    with endpoint: E
  ) -> AnyPublisher<Response<R>, Error> where E.Response == R {
    do {
      let urlRequest = try endpoint.urlRequest()
      return session.dataTaskPublisher(for: urlRequest)
        .tryMap { data, response in
          let output = try JSONDecoder().decode(R.self, from: data)
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
          return Response(output: output, statusCode: statusCode)
        }
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
}

// MARK: - Requestable + Utils

private extension Requestable {

  func urlRequest() throws -> URLRequest {
    let url = try url()
    var urlRequest = URLRequest(url: url)

    if let bodyParameters = try bodyParameters?.toDictionary(), !bodyParameters.isEmpty {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
    }

    urlRequest.httpMethod = method.rawValue
    headers?.forEach { key, value in
      urlRequest.setValue(value, forHTTPHeaderField: key)
    }

    if let authorization = authorization {
      urlRequest.setValue(authorization, forHTTPHeaderField: "Authorization")
    }

    return urlRequest
  }

  func url() throws -> URL {
    let fullPath = "\(baseURL)\(path)"
    guard var urlComponents = URLComponents(string: fullPath) else {
      throw NetworkError.urlComponentFailed
    }

    var queryItems = [URLQueryItem]()
    if let queryParameters = try queryParameters?.toDictionary() {
      queryParameters.forEach { key, value in
        queryItems.append(URLQueryItem(name: key, value: "\(value)"))
      }
    }

    urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems

    guard let url = urlComponents.url else {
      throw NetworkError.urlComponentFailed
    }

    return url
  }
}

// MARK: - Encodable + Utils

private extension Encodable {
  
  func toDictionary() throws -> [String: Any]? {
    let data = try JSONEncoder().encode(self)
    let jsonObject = try JSONSerialization.jsonObject(with: data)
    return jsonObject as? [String: Any]
  }
}
