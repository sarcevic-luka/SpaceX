//
//  LaunchFiltersPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Model

protocol LaunchFiltersViewPresentingLogic: AnyObject { }

class LaunchFiltersPresenter {
  var interactor: LaunchFiltersBusinessLogic?
  weak private var view: LaunchFiltersDisplayLogic?
  private var activeFilters: LaunchListFilters
  private let router: LaunchFiltersRoutingLogic
  
  init(activeFilters: LaunchListFilters, interface: LaunchFiltersDisplayLogic, interactor: LaunchFiltersBusinessLogic?, router: LaunchFiltersRoutingLogic) {
    self.view = interface
    self.interactor = interactor
    self.router = router
    self.activeFilters = activeFilters
  }
}

// MARK: - LaunchFiltersViewPresentingLogic
extension LaunchFiltersPresenter: LaunchFiltersViewPresentingLogic { }
