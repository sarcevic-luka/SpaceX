//
//  LaunchFiltersViewController.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Model

protocol LaunchFiltersDisplayLogic: AnyObject { }

class LaunchFiltersViewController: UIViewController {
  var presenter: LaunchFiltersViewPresentingLogic?
  private var filters: LaunchListFilters?
  private lazy var contentView = LaunchFiltersContentView()
  
  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

// MARK: - LaunchFiltersDisplayLogic
extension LaunchFiltersViewController: LaunchFiltersDisplayLogic { }

private extension LaunchFiltersViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {

  }
}
