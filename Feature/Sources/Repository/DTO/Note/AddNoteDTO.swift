//
//  NoteDTO.swift
//  
//
//  Created by 정동천 on 2023/03/03.
//

import Entity
import Foundation

struct AddNoteRequestDTO: Encodable {
  let title: String
}

struct AddNoteResponseDTO: Decodable {
  let id: String

  func toDomain(title: String) -> Note {
    return Note(id: id, title: title)
  }
}
