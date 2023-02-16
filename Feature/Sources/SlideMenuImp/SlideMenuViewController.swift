//
//  SlideMenuViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import FlashNotesUI
import ModernRIBs
import UIKit

protocol SlideMenuPresentableListener: AnyObject {
  func didTapAddPageButton()
  func didTapSettingButton()
  func didSelectItem(at index: Int)
}

final class SlideMenuViewController: UIViewController,
                                     SlideMenuPresentable,
                                     SlideMenuViewControllable {
  weak var listener: SlideMenuPresentableListener?

  private let pageListView = NoteListView()
  private let logoImageView: UIImageView = {
    let imageView = UIImageView(image: Images.icLogoTitle.image)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var plusButton: FloatingButton = {
    let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
    let image = UIImage(systemName: "plus", withConfiguration: configuration)
    let button = FloatingButton(image: image)
    let action = #selector(plusButtonDidTap)
    button.addTarget(self, action: action, for: .touchUpInside)
    button.setBackgorundColor(.white, for: .normal)
    button.setBackgorundColor(Colors.HighlightedWhite.color, for: .highlighted)
    return button
  }()

  private lazy var settingBarButton: UIBarButtonItem = {
    let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
    let image = UIImage(systemName: "gearshape.fill", withConfiguration: configuration)
    let action = #selector(settingButtonDidTap)
    let button = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    button.tintColor = Colors.backgroundWhite.color
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupLayout()
  }

  private func setup() {
    view.backgroundColor = Colors.backgroundOrange.color

    let leftBarButtonView = UIView(frame: .init(x: 0, y: 0, width: 150, height: 44))
    logoImageView.frame = CGRect(x: 5, y: 12, width: 134, height: 20)
    leftBarButtonView.addSubview(logoImageView)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonView)
    navigationItem.rightBarButtonItem = settingBarButton

    pageListView.delegate = self
  }

  private func setupLayout() {
    pageListView.translatesAutoresizingMaskIntoConstraints = false
    plusButton.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(pageListView)
    view.addSubview(plusButton)

    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      pageListView.topAnchor.constraint(equalTo: view.topAnchor),
      pageListView.leftAnchor.constraint(equalTo: view.leftAnchor),
      pageListView.rightAnchor.constraint(equalTo: view.rightAnchor),
      pageListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      plusButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
      plusButton.widthAnchor.constraint(equalToConstant: 50),
      plusButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  @objc
  private func plusButtonDidTap() {
    listener?.didTapAddPageButton()
  }

  @objc
  private func settingButtonDidTap() {
    listener?.didTapSettingButton()
  }
}

// MARK: - UITableViewDelegate

extension SlideMenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    listener?.didSelectItem(at: indexPath.row)
  }
}
