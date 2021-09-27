//
//  LaunchListContentView.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Assets

class LaunchListContentView: UIView {
  var refreshControlRefreshHandler: Action?
  private(set) lazy var tableView = UITableView(frame: .zero, style: .plain)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension LaunchListContentView {
  @objc func refreshControlValueChanged() {
    refreshControlRefreshHandler?()
  }
}

private extension LaunchListContentView {
  func setupViews() {
    setupView()
    setupTableView()
  }

  func setupView() {
    backgroundColor = ColorAssets.General.white.color
  }

  func setupTableView() {
    addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.bottom.equalTo(safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    tableView.backgroundColor = ColorAssets.General.white.color
    tableView.alwaysBounceVertical = true
    tableView.separatorStyle = .none
    tableView.register(LaunchListCompanyInfoCell.self)
    tableView.register(LaunchListCell.self)
    tableView.register(HeaderView.self)
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
  }
}
