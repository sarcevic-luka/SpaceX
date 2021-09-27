//
//  AlertContentView.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Assets

class AlertContentView: UIView {
  var actionTapHandler: ParametrisedAction<Int>?
  private lazy var blurView = UIVisualEffectView(effect: blurEffect)
  private lazy var blurEffect = UIBlurEffect(style: .light)
  private lazy var infoViewContainer = UIView()
  private lazy var infoView = StackedInfoView()
  private lazy var actionsStackView = UIStackView()
  private lazy var actionButton = UIButton(type: .system)
  private let infoViewContainerWidthReference: CGFloat = 320 / 375

  init(title: String?, message: String?, attributedMessage: NSAttributedString? = nil, actions: [AlertAction]) {
    super.init(frame: .zero)
    setupViews(actions: actions)
    update(title: title, message: message, attributedMessage: attributedMessage)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension AlertContentView {
  func update(title: String?, message: String?, attributedMessage: NSAttributedString?) {
    infoView.title = title
    infoView.subtitle = message
  }
}

// MARK: - Actions
private extension AlertContentView {
  @objc func actionButtonTapped(_ sender: UIButton) {
    actionTapHandler?(sender.tag)
  }
}

// MARK: - Private Methods
private extension AlertContentView {
  func setupViews(actions: [AlertAction]) {
    setupBlurView()
    setupInfoViewContainer()
    setupInfoView()
    if !actions.isEmpty {
      setupActionsStackView(actions: actions)
    }
  }

  func setupBlurView() {
    addSubview(blurView)
    blurView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    blurView.backgroundColor = ColorAssets.General.gray.color.withAlphaComponent(0.2)
  }

  func setupInfoViewContainer() {
    blurView.contentView.addSubview(infoViewContainer)
    infoViewContainer.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(infoViewContainerWidthReference)
    }
    infoViewContainer.backgroundColor = ColorAssets.General.white.color
    infoViewContainer.layer.cornerRadius = 16
    infoViewContainer.clipsToBounds = true
  }

  func setupInfoView() {
    infoViewContainer.addSubview(infoView)
    infoView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(24).priority(.high)
      $0.top.equalToSuperview().inset(32)
    }
    infoView.spacing = 12
    infoView.titleAlignmnent = .center
    infoView.titleNumberOfLines = 0
    infoView.subtitleAlignmnent = .center
    infoView.subtitleNumberOfLines = 0
  }

  func setupActionsStackView(actions: [AlertAction]) {
    infoViewContainer.addSubview(actionsStackView)
    actionsStackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalTo(infoView.snp.bottom).offset(16)
      $0.bottom.equalToSuperview().inset(24)
    }
    actionsStackView.axis = .vertical
    actionsStackView.distribution = .fill
    actionsStackView.alignment = .fill
    actionsStackView.spacing = 12

    let buttons = actions
      .enumerated()
      .map { createActionButton(using: $0.element, tag: $0.offset) }
    
    buttons.forEach { button in
      actionsStackView.addArrangedSubview(button)
    }
  }

  func createActionButton(using action: AlertAction, tag: Int) -> UIButton {
    let actionButton = UIButton(type: .system)
    actionButton.snp.makeConstraints {
      $0.height.equalTo(56)
    }
    actionButton.setTitle(action.title, for: .normal)
    actionButton.setTitleColor(action.style.actionTitleColor, for: .normal)
    actionButton.titleLabel?.font = action.style.actionTitleFont
    actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
    actionButton.tag = tag
    return actionButton
  }
}

private extension AlertAction.Style {
  var actionTitleColor: UIColor {
    switch self {
    case .default:
      return ColorAssets.General.red.color
    case .preferred:
      return ColorAssets.General.appBlack.color
    }
  }

  var actionTitleFont: UIFont {
    .appFont(size: 16, weight: .medium)
  }
}
