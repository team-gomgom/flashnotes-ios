//
//  PageListCellViewModel.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Entity

struct PageListCellViewModel {
  let question: String

  init(page: Page) {
    self.question = page.question
  }
}
