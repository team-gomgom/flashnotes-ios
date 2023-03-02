//
//  PageViewController.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/03/02.
//

import ModernRIBs
import Resource
import UIKit

protocol PagePresentableListener: AnyObject {}

final class PageViewController: UIViewController,
                                PagePresentable,
                                PageViewControllable {
  weak var listener: PagePresentableListener?

  private let titleView: UILabel = {
    let label = UILabel()
    label.textColor = .secondarySystemBackground
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    return label
  }()

  private let questionView = PageQuestionView()
  private let answerView = PageAnswerView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupLayout()
  }

  private func setup() {
    view.backgroundColor = .systemOrange
    navigationItem.titleView = titleView
  }

  private func setupLayout() {
    questionView.translatesAutoresizingMaskIntoConstraints = false
    answerView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(questionView)
    view.addSubview(answerView)

    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      questionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      questionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      questionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      questionView.heightAnchor.constraint(equalToConstant: 200),
      answerView.topAnchor.constraint(equalTo: questionView.bottomAnchor),
      answerView.leftAnchor.constraint(equalTo: view.leftAnchor),
      answerView.rightAnchor.constraint(equalTo: view.rightAnchor),
      answerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}
