//
//  MockURLProtocol.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/06.
//

import Foundation

enum MockSessionError: Error {
  case notSupported
}

struct MockRequest: Hashable {
  let url: URL
  let method: String
}

typealias MockResponse = (statusCode: Int, data: Data?)

final class MockURLProtocol: URLProtocol {

  static var baseURL: String!

  static var successMock: [MockRequest: MockResponse] = [:]
  static var failureErrors: [MockRequest: Error] = [:]

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    guard let url = request.url, let method = request.httpMethod else {
      client?.urlProtocolDidFinishLoading(self)
      return
    }

    let mockRequest = MockRequest(url: url, method: method)
    if let mockResponse = Self.successMock[mockRequest] {

      let urlResponse = HTTPURLResponse(
        url: request.url!,
        statusCode: mockResponse.statusCode,
        httpVersion: nil,
        headerFields: nil
      )
      client?.urlProtocol(self, didReceive: urlResponse!, cacheStoragePolicy: .notAllowed)
      mockResponse.data.map { data in
        client?.urlProtocol(self, didLoad: data)
      }
    } else if let error = Self.failureErrors[mockRequest] {
      client?.urlProtocol(self, didFailWithError: error)
    } else {
      client?.urlProtocol(self, didFailWithError: MockSessionError.notSupported)
    }

    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}
}
