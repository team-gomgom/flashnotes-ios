//
//  AddPageViewController.swift
//  
//
//  Created by 정동천 on 2023/03/19.
//

import ModernRIBs
import Resource
import UIKit

protocol AddPagePresentableListener: AnyObject {
  func doneButtonDidTap(withQuestion question: String, answer: String)
}

final class AddPageViewController: UIViewController,
                                   AddPageViewControllable {

  weak var listener: AddPagePresentableListener?

  private let titleView: UILabel = {
    let label = UILabel()
    label.textColor = .secondarySystemBackground
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()

  private lazy var rightBarButtonItem: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: L10n.Action.done,
      style: .done,
      target: self,
      action: #selector(rightBarButtonDidTap)
    )
    button.tintColor = .secondarySystemBackground
    return button
  }()

  private let questionView = PageQuestionView()
  private let answerView = PageAnswerView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupLayout()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    _ = questionView.becomeFirstResponder()
  }
}

// MARK: - AddPagePresentable

extension AddPageViewController: AddPagePresentable {

  func updateTitle(_ title: String?) {
    titleView.text = title
  }
}

// MARK: - Private

extension AddPageViewController {

  func setup() {
    view.backgroundColor = .systemOrange
    navigationItem.titleView = titleView
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  func setupLayout() {
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

  @objc
  func rightBarButtonDidTap() {
    let question = questionView.question
    let answer = answerView.answer
    listener?.doneButtonDidTap(withQuestion: question, answer: answer)
  }
}
