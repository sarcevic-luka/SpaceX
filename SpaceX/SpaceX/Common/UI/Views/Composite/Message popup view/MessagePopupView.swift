//
//  MessagePopupView.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Assets

open class MessagePopupView: UIView {
  var actionHandler: Action?
  let autoDismissInterval: TimeInterval?
  private lazy var imageView = UIImageView()
  private let verticalStackView = UIStackView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private(set) lazy var actionButton = UIButton()
  private let context: MessagePopupView.State
  
  init(context: MessagePopupView.State, autoDismissInterval: TimeInterval? = 5.5) {
    self.context = context
    self.autoDismissInterval = autoDismissInterval
    super.init(frame: .zero)
    setupViews()
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
  }
}

// MARK: - Private Methods
private extension MessagePopupView {
  @objc func actionButtonTapped() {
    actionHandler?()
  }
}

private extension MessagePopupView {
  func setupViews() {
    setupView()
    setupImageView()
    setupStackView()
    setupTitleLabel()
    setupSubtitleLabel()
    setupButton()
  }
  
  func setupView() {
    backgroundColor = context.backgroundColor
    layer.borderWidth = 4
    layer.borderColor = ColorAssets.General.red.color.cgColor
    layer.cornerRadius = 16
  }
  
  func setupImageView() {
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(12)
      $0.top.bottom.equalToSuperview()
      $0.size.equalTo(100)
    }
    imageView.image = context.image
    imageView.contentMode = .center
  }
  
  func setupStackView() {
    addSubview(verticalStackView)
    verticalStackView.snp.makeConstraints {
      $0.leading.equalTo(imageView.snp.trailing).offset(8)
      $0.trailing.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(0)
    }
    verticalStackView.alignment = .leading
    verticalStackView.distribution = .fillProportionally
    verticalStackView.axis = .vertical
  }
  
  func setupTitleLabel() {
    verticalStackView.addArrangedSubview(titleLabel)
    titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    titleLabel.text = context.title
    titleLabel.textColor = ColorAssets.General.gray.color
  }
  
  func setupSubtitleLabel() {
    guard let subtitle = context.subtitle else { return }
    verticalStackView.addArrangedSubview(subtitleLabel)
    subtitleLabel.numberOfLines = 0
    subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    subtitleLabel.text = subtitle
    subtitleLabel.textColor = ColorAssets.General.gray.color
  }
  
  func setupButton() {
    addSubview(actionButton)
    actionButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(6)
      $0.size.equalTo(24)
      $0.trailing.equalToSuperview().inset(6)
    }
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    actionButton.setImage(ImageAssets.Icons.close.image, for: .normal)
  }
}
