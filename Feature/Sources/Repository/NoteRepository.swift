//
//  NoteRepository.swift
//  
//
//  Created by 정동천 on 2023/03/03.
//

import Combine
import CombineUtil
import Foundation
import Entity
import Network

public protocol NoteRepository: AnyObject {
  var authorization: String { get set }
  var notes: ReadOnlyCurrentValuePublisher<[Note]> { get }

  func getNotes() -> AnyPublisher<[Note], Error>
  func addNote(title: String) -> AnyPublisher<Note, Error>
}

public final class NoteRepositoryImp: NoteRepository {
  public var authorization: String
  public var notes: ReadOnlyCurrentValuePublisher<[Note]> { _notes }

  private let _notes = CurrentValuePublisher<[Note]>([])
  private let network: Network
  private let baseURL: String

  public init(network: Network, baseURL: String, authorization: String) {
    self.network = network
    self.baseURL = baseURL
    self.authorization = authorization
  }

  public func getNotes() -> AnyPublisher<[Note], Error> {
    let endpoint = Endpoint<ResponseDTO<NoteResponseDTO>>(
      baseURL: baseURL,
      path: "/api/v1/note",
      method: .get,
      authorization: authorization
    )
    return network.request(with: endpoint)
      .tryMap { response -> [Note] in
        try response.output.validate(statusCode: response.statusCode)
        let responseDTOs = try response.output.values()
        return responseDTOs.map { $0.toDomain() }
      }
      .handleEvents(
        receiveOutput: { [_notes] notes in
          _notes.send(notes)
        }
      )
      .eraseToAnyPublisher()
  }

  public func addNote(title: String) -> AnyPublisher<Note, Error> {
    let requestDTO = AddNoteRequestDTO(title: title)
    let endpoint = Endpoint<ResponseDTO<AddNoteResponseDTO>>(
      baseURL: baseURL,
      path: "/api/v1/note",
      method: .post,
      bodyParameters: requestDTO,
      authorization: authorization
    )
    return network.request(with: endpoint)
      .tryMap { response -> Note in
        try response.output.validate(statusCode: response.statusCode)
        let responseDTO = try response.output.just()
        return responseDTO.toDomain(title: title)
      }
      .handleEvents(
        receiveOutput: { [_notes] note in
          _notes.send(_notes.value + [note])
        }
      )
      .eraseToAnyPublisher()
  }
}
