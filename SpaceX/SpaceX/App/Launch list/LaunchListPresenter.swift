//
//  LaunchListPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol LaunchListViewPresentingLogic: AnyObject { }

class LaunchListPresenter {
  var interactor: LaunchListBusinessLogic?
  weak private var view: LaunchListDisplayLogic?
  private let router: LaunchListRoutingLogic
  
  init(interface: LaunchListDisplayLogic, interactor: LaunchListBusinessLogic?, router: LaunchListRoutingLogic) {
    self.view = interface
    self.interactor = interactor
    self.router = router
  }
}

// MARK: - LaunchListViewPresentingLogic
extension LaunchListPresenter: LaunchListViewPresentingLogic { }
