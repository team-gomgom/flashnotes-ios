//
//  PageListView.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/17.
//

import FlashNotesUI
import UIKit

final class PageListView: UITableView {

  var viewModels: [PageListCellViewModel] = [] {
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
    tableHeaderView = UIView()
  }
}

// MARK: - UITableViewDataSource

extension PageListView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(PageListCell.self, for: indexPath)
    let viewModel = viewModels[indexPath.row]
    cell.configure(viewModel: viewModel)
    return cell
  }
}
