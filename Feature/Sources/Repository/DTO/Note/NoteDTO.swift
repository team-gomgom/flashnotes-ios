//
//  NoteDTO.swift
//  
//
//  Created by 정동천 on 2023/03/03.
//

import Entity
import Foundation

struct NoteResponseDTO: Decodable {
  let id: String
  let title: String

  func toDomain() -> Note {
    return Note(id: id, title: title)
  }
}
