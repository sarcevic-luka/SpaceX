//
//  LaunchListCompanyInfoCell.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit
import Assets
import SnapKit

class LaunchListCompanyInfoCell: UICollectionViewCell {
  struct ViewModel {
    let info: String
  }
  private lazy var infoLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LaunchListCompanyInfoCell {
  func update(_ viewModel: ViewModel) {
    infoLabel.text = viewModel.info
  }
}

// MARK: - Private Methods
private extension LaunchListCompanyInfoCell {
  func setupViews() {
    setupView()
    setupInfoLabel()
  }
  
  func setupView() {
    contentView.backgroundColor = ColorAssets.General.appWhite.color
  }
  
  func setupInfoLabel() {
    addSubview(infoLabel)
    infoLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(12)
    }
    infoLabel.font = .appFont(size: 14, weight: .regular)
    infoLabel.textColor = ColorAssets.General.appBlack.color
    infoLabel.numberOfLines = 0
  }
}
