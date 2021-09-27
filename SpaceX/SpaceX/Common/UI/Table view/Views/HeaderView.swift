//
//  HeaderView.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit
import Assets
import SnapKit

class HeaderView: UITableViewHeaderFooterView {
  private lazy var titleLabel = UILabel()
  private lazy var backgroundColorView = UIView()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupViews()
  }
    
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HeaderView {
  var titleText: String? {
    get { titleLabel.text }
    set { titleLabel.text = newValue }
  }
}

// MARK: - Private Methods
private extension HeaderView {
  func setupViews() {
    setupView()
    setupTitleLabel()
  }

  func setupView() {
    addSubview(backgroundColorView)
    backgroundColorView.snp.makeConstraints {
      $0.edges.equalToSuperview()

    }
    backgroundColorView.backgroundColor = ColorAssets.General.appBlack.color
  }

  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    titleLabel.font = .appFont(size: 16, weight: .bold)
    titleLabel.textColor = ColorAssets.General.white.color
    titleLabel.textAlignment = .left
  }
}
