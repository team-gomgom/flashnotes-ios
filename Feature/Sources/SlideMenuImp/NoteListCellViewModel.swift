//
//  NoteListCellViewModel.swift
//  
//
//  Created by 정동천 on 2023/02/16.
//

import Entity

struct NoteListCellViewModel {
  let title: String

  init(note: Note) {
    self.title = note.title
  }
}
