//
//  AlertViewController.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Assets

class AlertViewController: UIViewController {
  private let contentView: AlertContentView
  private let actions: [AlertAction]

  init(title: String?, message: String? = nil, attributedMessage: NSAttributedString? = nil, actions: [AlertAction]) {
    self.contentView = AlertContentView(title: title, message: message, attributedMessage: attributedMessage, actions: actions)
    self.actions = actions
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

private extension AlertViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    contentView.actionTapHandler = { [weak self] actionIndex in
      self?.actions[safe: actionIndex]?.action?()
    }
  }
}
