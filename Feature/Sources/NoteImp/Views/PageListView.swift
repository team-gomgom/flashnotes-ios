//
//  PageListView.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import Entity
import FlashNotesUI
import UIKit

final class PageListView: UITableView {
  var pages: [Page] = [] {
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
    backgroundColor = .secondarySystemBackground
    register(PageListCell.self)
    dataSource = self
    rowHeight = UITableView.automaticDimension
  }
}

// MARK: - UITableViewDataSource

extension PageListView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(PageListCell.self, for: indexPath)
    let viewModel = PageListCellViewModel(page: pages[indexPath.row])
    cell.configure(viewModel: viewModel)
    return cell
  }
}
