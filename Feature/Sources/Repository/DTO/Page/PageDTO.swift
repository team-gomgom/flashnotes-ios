//
//  PageDTO.swift
//  
//
//  Created by 정동천 on 2023/03/06.
//

import Entity
import Foundation

struct PageRequestDTO: Encodable {
  let noteId: String
}

struct PageResponseDTO: Decodable {
  let id: String
  let question: String
  let answer: String?

  func toDomain() -> Page {
    return Page(id: id, question: question, answer: answer)
  }
}
