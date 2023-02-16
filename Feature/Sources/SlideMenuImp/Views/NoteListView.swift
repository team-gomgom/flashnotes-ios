//
//  PageListView.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import Entity
import FlashNotesUI
import UIKit

final class NoteListView: UITableView {
  var notes: [Note] = [] {
    didSet { reloadData() }
  }

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)

    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    backgroundColor = .clear
    separatorStyle = .none
    register(NoteListCell.self)
    dataSource = self
  }
}

// MARK: - UITableViewDataSource

extension NoteListView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(NoteListCell.self, for: indexPath)
    let viewModel = NoteListCellViewModel(note: notes[indexPath.row])
    cell.configure(viewModel: viewModel)
    return cell
  }
}
