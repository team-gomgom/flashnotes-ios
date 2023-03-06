//
//  PageRepository.swift
//  
//
//  Created by 정동천 on 2023/03/06.
//

import Combine
import CombineUtil
import Foundation
import Entity
import Network

public protocol PageRepository: AnyObject {
  var authorization: String { get set }
  var noteID: String { get set }
  var pages: ReadOnlyCurrentValuePublisher<[Page]> { get }

  func getPages() -> AnyPublisher<[Page], Error>
  func addPage(question: String, answer: String?) -> AnyPublisher<Page, Error>
}

public final class PageRepositoryImp: PageRepository {
  public var authorization: String
  public var noteID: String
  public var pages: ReadOnlyCurrentValuePublisher<[Page]> { _pages }

  private let _pages = CurrentValuePublisher<[Page]>([])
  private let network: Network
  private let baseURL: String

  public init(network: Network, baseURL: String, authorization: String, noteID: String) {
    self.network = network
    self.baseURL = baseURL
    self.authorization = authorization
    self.noteID = noteID
  }

  public func getPages() -> AnyPublisher<[Page], Error> {
    let requestDTO = PageRequestDTO(noteId: noteID)
    let endpoint = Endpoint<ResponseDTO<PageResponseDTO>>(
      baseURL: baseURL,
      path: "/api/v1/page",
      method: .get,
      queryParameters: requestDTO,
      authorization: authorization
    )
    return network.request(with: endpoint)
      .tryMap { response -> [Page] in
        try response.output.validate(statusCode: response.statusCode)
        let responseDTOs = try response.output.values()
        return responseDTOs.map { $0.toDomain() }
      }
      .handleEvents(
        receiveOutput: { [_pages] pages in
          _pages.send(pages)
        }
      )
      .eraseToAnyPublisher()
  }

  public func addPage(question: String, answer: String?) -> AnyPublisher<Page, Error> {
    let requestDTO = AddPageRequestDTO(noteId: noteID, question: question, answer: answer)
    let endpoint = Endpoint<ResponseDTO<AddPageResponseDTO>>(
      baseURL: baseURL,
      path: "/api/v1/page",
      method: .post,
      bodyParameters: requestDTO,
      authorization: authorization
    )
    return network.request(with: endpoint)
      .tryMap { response -> Page in
        try response.output.validate(statusCode: response.statusCode)
        let responseDTO = try response.output.just()
        return responseDTO.toDomain(question: question, answer: answer)
      }
      .handleEvents(
        receiveOutput: { [_pages] page in
          _pages.send(_pages.value + [page])
        }
      )
      .eraseToAnyPublisher()
  }
}
