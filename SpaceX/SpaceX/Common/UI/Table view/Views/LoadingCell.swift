//
//  LoadingCell.swift
//  SpaceX
//
//  Created by Luka Šarčević on 19.10.2021..
//

import UIKit
import Assets
import SnapKit

class LoadingCell: UITableViewCell {
  private let indicatorView = UIActivityIndicatorView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoadingCell {
  func startIndicatorViewAnimation() {
    indicatorView.startAnimating()
  }
}

private extension LoadingCell {
  func setupViews() {
    setupView()
    setupIndicatorView()
  }
  
  func setupView() {
    contentView.backgroundColor = ColorAssets.General.white.color
    backgroundColor = ColorAssets.General.white.color
  }

  func setupIndicatorView() {
    addSubview(indicatorView)
    indicatorView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.edges.equalToSuperview()
      $0.height.equalTo(CellHeights.launchListCell)
    }
    indicatorView.hidesWhenStopped = true
    indicatorView.color = ColorAssets.General.gray.color
  }
}
