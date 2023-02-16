//
//  FloatingButton.swift
//  FlashNotes
//
//  Created by 정동천 on 2023/02/15.
//

import UIKit

public final class FloatingButton: UIView {
  public var image: UIImage? {
    didSet { imageView.image = image }
  }

  private var imageView: UIImageView!
  private let button = UIButton()
  private let shadowLayer: ShadowLayer = {
    let offSet = CGSize(width: 0, height: 2)
    return ShadowLayer(offSet: offSet, blur: 2)
  }()

  public init(image: UIImage? = nil) {
    self.imageView = UIImageView(image: image)
    super.init(frame: .zero)

    setup()
    setupShadow()
    setupLayout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    round()
    button.round()
    shadowLayer.setPath(view: self)
  }

  public func setBackgorundColor(_ color: UIColor, for state: UIControl.State) {
    button.setBackgorundColor(color, for: state)
  }

  public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
    button.addTarget(target, action: action, for: controlEvents)
  }
}

// MARK: - Private Methods

private extension FloatingButton {
  func setup() {
    clipsToBounds = false
    button.backgroundColor = .white
    button.clipsToBounds = true
  }

  func setupShadow() {
    layer.insertSublayer(shadowLayer, at: 0)
  }

  func setupLayout() {
    button.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(button)
    button.addSubview(imageView)

    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: topAnchor),
      button.leftAnchor.constraint(equalTo: leftAnchor),
      button.rightAnchor.constraint(equalTo: rightAnchor),
      button.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
    ])
  }
}
