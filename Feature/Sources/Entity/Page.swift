//
//  Page.swift
//  
//
//  Created by 정동천 on 2023/02/17.
//

public struct Page: Equatable, Identifiable {
  public typealias Identifer = String

  public let id: Identifer
  public let question: String
  public let answer: String?

  public init(
    id: String,
    question: String,
    answer: String?
  ) {
    self.id = id
    self.question = question
    self.answer = answer
  }

  public static func == (lhs: Page, rhs: Page) -> Bool {
    return lhs.id == rhs.id
  }
}
