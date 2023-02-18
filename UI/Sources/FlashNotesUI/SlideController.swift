//
//  SlideController.swift
//  
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

open class SlideController: UIViewController {
  // MARK: Public Properties

  private(set) var isExpanded: Bool = false
  public var isGestureEnabled: Bool = true
  public var slideMenuMaximumWidth: CGFloat = 260
  public var dimmedMaximumAlpha: CGFloat = 0.4 {
    didSet {
      dimmedView.backgroundColor = .black.withAlphaComponent(dimmedMaximumAlpha)
    }
  }

  public var slideMenuViewController: UIViewController? {
    didSet {
      oldValue?.view.constraints.forEach { constraint in
        oldValue?.view.removeConstraint(constraint)
      }
      dimmedView.removeFromSuperview()
      oldValue?.view.removeFromSuperview()
      setupSlideMenuLayout()
    }
  }

  public var rootViewController: UIViewController? {
    get {
      rootNavigationController.viewControllers.first
    }
    set {
      let viewControllers = newValue.map { [$0] } ?? []
      newValue?.navigationItem.leftBarButtonItem = slideBarButtonItem
      rootNavigationController.setViewControllers(viewControllers, animated: true)
    }
  }

  public lazy var slideBarButtonItem = UIBarButtonItem(
    image: UIImage(systemName: "sidebar.left"),
    style: .plain,
    target: self,
    action: #selector(slideButtonDidTap)
  )

  // MARK: Private Properties

  private var rootNavigationController: UINavigationController!
  private var isDraggingEnabled: Bool = false
  private var panBaseLocation: CGFloat = 0
  private let dimmedView = UIView()

  public init(navigationController: UINavigationController) {
    self.rootNavigationController = navigationController
    super.init(nibName: nil, bundle: nil)
  }

  public init(
    slideMenuViewController: UIViewController,
    navigationController: UINavigationController
  ) {
    self.slideMenuViewController = slideMenuViewController
    self.rootNavigationController = navigationController
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupNavigationLayout()
    setGestureRecognizer()
  }
}

// MARK: - Public Method

public extension SlideController {
  func expandSlideMenu() {
    updateSlideMenu(willExpand: true)
  }

  func collapseSlideMenu() {
    updateSlideMenu(willExpand: false)
  }
}

// MARK: - Private Method

private extension SlideController {
  func setup() {
    rootViewController?.navigationItem.leftBarButtonItem = slideBarButtonItem
    dimmedView.backgroundColor = .black.withAlphaComponent(dimmedMaximumAlpha)
    dimmedView.alpha = 1
  }

  func setupSlideMenuLayout() {
    guard let slideMenuViewController = slideMenuViewController else { return }

    let slideMenuView = slideMenuViewController.view!
    slideMenuView.translatesAutoresizingMaskIntoConstraints = false
    dimmedView.translatesAutoresizingMaskIntoConstraints = false

    addChild(slideMenuViewController)
    view.insertSubview(slideMenuView, at: 0)
    slideMenuViewController.didMove(toParent: self)

    slideMenuView.addSubview(dimmedView)

    NSLayoutConstraint.activate([
      slideMenuView.topAnchor.constraint(equalTo: view.topAnchor),
      slideMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      slideMenuView.widthAnchor.constraint(equalToConstant: slideMenuMaximumWidth),
      dimmedView.topAnchor.constraint(equalTo: slideMenuView.topAnchor),
      dimmedView.leftAnchor.constraint(equalTo: slideMenuView.leftAnchor),
      dimmedView.rightAnchor.constraint(equalTo: slideMenuView.rightAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: slideMenuView.bottomAnchor)
    ])
  }

  func setupNavigationLayout() {
    let navigationView = rootNavigationController.view!
    navigationView.translatesAutoresizingMaskIntoConstraints = false

    addChild(rootNavigationController)
    view.insertSubview(navigationView, at: 1)
    rootNavigationController.didMove(toParent: self)

    NSLayoutConstraint.activate([
      navigationView.topAnchor.constraint(equalTo: view.topAnchor),
      navigationView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navigationView.rightAnchor.constraint(equalTo: view.rightAnchor),
      navigationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  func setGestureRecognizer() {
    let panGestureRecognizer = UIPanGestureRecognizer(
      target: self,
      action: #selector(panGestureHandler)
    )
    panGestureRecognizer.delegate = self
    view.addGestureRecognizer(panGestureRecognizer)

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(tapGestureHandler)
    )
    tapGestureRecognizer.numberOfTapsRequired = 1
    tapGestureRecognizer.delegate = self
    view.addGestureRecognizer(tapGestureRecognizer)
  }

  func updateSlideMenu(willExpand: Bool) {
    let position: CGFloat = willExpand ? slideMenuMaximumWidth : 0
    moveSlideMenu(targetPosition: position) { [weak self] _ in
      self?.isExpanded = willExpand
    }
  }

  func moveSlideMenu(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
    let alpha = (slideMenuMaximumWidth - targetPosition) / slideMenuMaximumWidth

    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      usingSpringWithDamping: 1.0,
      initialSpringVelocity: 0,
      options: .layoutSubviews,
      animations: {
        self.view.subviews[1].frame.origin.x = targetPosition
        self.dimmedView.alpha = alpha
      },
      completion: completion
    )
  }

  @objc
  func slideButtonDidTap() {
    updateSlideMenu(willExpand: !isExpanded)
  }

  @objc
  func panGestureHandler(gestureRecognizer: UIPanGestureRecognizer) {
    guard isGestureEnabled else { return }

    let position = gestureRecognizer.translation(in: view).x
    let velocity = gestureRecognizer.velocity(in: view).x

    switch gestureRecognizer.state {
    case .began:
      if velocity > 0, isExpanded {
        gestureRecognizer.state = .cancelled
      } else if velocity > 0, !isExpanded {
        isDraggingEnabled = true
      } else if velocity < 0, isExpanded {
        isDraggingEnabled = true
      }

      guard isDraggingEnabled else { return }

      let velocityThreshold: CGFloat = 1200
      if abs(velocity) > velocityThreshold {
        updateSlideMenu(willExpand: !isExpanded)
        isDraggingEnabled = false
        return
      }

    case .changed:
      guard isDraggingEnabled else { return }

      if let recognizedView = gestureRecognizer.view?.subviews[1] {
        let alpha = (slideMenuMaximumWidth - recognizedView.frame.origin.x) / slideMenuMaximumWidth
        if alpha >= 0, alpha <= 1 {
          dimmedView.alpha = alpha
        }

        if recognizedView.frame.origin.x >= 0,
           recognizedView.frame.origin.x <= slideMenuMaximumWidth - position {
          recognizedView.frame.origin.x += position
          gestureRecognizer.setTranslation(.zero, in: view)
        }
      }

    case .ended:
      isDraggingEnabled = false
      if let recognizedView = gestureRecognizer.view?.subviews[1] {
        let isMovedMoreThanHalf = recognizedView.frame.origin.x > slideMenuMaximumWidth * 0.5
        updateSlideMenu(willExpand: isMovedMoreThanHalf)
      }

    default:
      break
    }
  }

  @objc
  func tapGestureHandler(gestureRecognizer: UITapGestureRecognizer) {
    if gestureRecognizer.state == .ended, isExpanded {
      updateSlideMenu(willExpand: false)
    }
  }
}

// MARK: - UIGestureRecognizerDelegate

extension SlideController: UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldReceive touch: UITouch
  ) -> Bool {
    guard let slideMenuView = slideMenuViewController?.view else { return false }

    if gestureRecognizer is UITapGestureRecognizer {
      return !(touch.view!.isDescendant(of: slideMenuView))
    }
    return true
  }
}
