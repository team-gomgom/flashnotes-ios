//
//  AddPageDTO.swift
//  
//
//  Created by 정동천 on 2023/03/06.
//

import Entity
import Foundation

struct AddPageRequestDTO: Encodable {
  let noteId: String
  let question: String
  let answer: String?
}

struct AddPageResponseDTO: Decodable {
  let id: String

  func toDomain(question: String, answer: String?) -> Page {
    return Page(id: id, question: question, answer: answer)
  }
}
