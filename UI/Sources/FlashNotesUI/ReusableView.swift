//
//  File.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

fileprivate protocol ReusableView: AnyObject {}

fileprivate extension ReusableView {
  static var reuseIdentifier: String {
    String(describing: self)
  }
}

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}

// MARK: - UITableView + Utils

public extension UITableView {
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
    let identifier = cellClass.reuseIdentifier
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("\(cellClass)타입으로 타입캐스팅에 실패하였습니다.")
    }
    return cell
  }
}

// MARK: - UICollectionView + Utils

public extension UICollectionView {
  func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
  }

  func register<T: UICollectionReusableView>(_ viewClass: T.Type, kind: SupplementaryViewType) {
    register(
      viewClass,
      forSupplementaryViewOfKind: kind.elmentKind,
      withReuseIdentifier: viewClass.reuseIdentifier
    )
  }

  func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
    let identifier = cellClass.reuseIdentifier
    guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
      fatalError("\(cellClass)타입으로 타입캐스팅에 실패하였습니다.")
    }
    return cell
  }

  func dequeueReusableSectionHeaderView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
    guard let view = dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: viewClass.reuseIdentifier,
      for: indexPath) as? T else {
      fatalError("\(viewClass)타입으로 타입캐스팅에 실패하였습니다.")
    }
    return view
  }

  func dequeueReusableSectionFooterView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
    guard let view = dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: viewClass.reuseIdentifier,
      for: indexPath) as? T else {
      fatalError("\(viewClass)타입으로 타입캐스팅에 실패하였습니다.")
    }
    return view
  }

  enum SupplementaryViewType {
    case header, footer

    var elmentKind: String {
      switch self {
      case .header: return UICollectionView.elementKindSectionHeader
      case .footer: return UICollectionView.elementKindSectionFooter
      }
    }
  }
}
