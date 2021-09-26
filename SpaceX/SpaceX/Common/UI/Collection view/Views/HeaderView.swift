//
//  HeaderView.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit
import Assets
import SnapKit

class HeaderView: UICollectionReusableView {
  struct ViewModel {
    let title: String
  }
  private lazy var titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HeaderView {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
  }
}

// MARK: - Private Methods
private extension HeaderView {
  func setupViews() {
    setupView()
    setupTitleLabel()
  }

  func setupView() {
    self.backgroundColor = ColorAssets.General.appBlack.color
  }

  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    titleLabel.font = .appFont(size: 16, weight: .bold)
    titleLabel.textColor = ColorAssets.General.appWhite.color
    titleLabel.textAlignment = .left
  }
}
