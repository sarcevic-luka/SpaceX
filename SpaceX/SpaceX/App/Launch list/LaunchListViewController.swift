//
//  LaunchListViewController.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LaunchListDisplayLogic: AnyObject { }

class LaunchListViewController: UIViewController {
  var presenter: LaunchListViewPresentingLogic?
  private lazy var contentView = LaunchListContentView()
  
  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

// MARK: - LaunchListDisplayLogic
extension LaunchListViewController: LaunchListDisplayLogic { }

private extension LaunchListViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() { }
}
