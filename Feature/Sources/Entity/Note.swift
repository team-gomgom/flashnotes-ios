//
//  Note.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

public struct Note: Equatable, Identifiable {
  public typealias Identifer = String

  public let id: Identifer
  public let title: String

  public init(
    id: String,
    title: String
  ) {
    self.id = id
    self.title = title
  }

  public static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.id == rhs.id
  }
}
