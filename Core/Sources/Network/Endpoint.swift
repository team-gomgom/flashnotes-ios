//
//  Endpoint.swift
//  
//
//  Created by 정동천 on 2023/02/14.
//

import Foundation

public protocol Responsable {
  associatedtype Response
}

public protocol Requestable {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var queryParameters: Encodable? { get }
  var bodyParameters: Encodable? { get }
  var authorization: String? { get }
  var headers: [String: String]? { get }
}

public protocol RequestResponsable: Requestable, Responsable {}

public class Endpoint<R>: RequestResponsable {
  public typealias Response = R

  public var baseURL: String
  public var path: String
  public var method: HTTPMethod
  public var queryParameters: Encodable?
  public var bodyParameters: Encodable?
  public var authorization: String?
  public var headers: [String: String]?

  public init(
    baseURL: String,
    path: String,
    method: HTTPMethod,
    queryParameters: Encodable? = nil,
    bodyParameters: Encodable? = nil,
    authorization: String? = nil,
    headers: [String: String]? = nil
  ) {
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.queryParameters = queryParameters
    self.bodyParameters = bodyParameters
    self.authorization = authorization
    self.headers = headers
  }
}
