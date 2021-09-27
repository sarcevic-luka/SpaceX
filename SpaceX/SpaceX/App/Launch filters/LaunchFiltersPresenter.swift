//
//  LaunchFiltersPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Model

protocol LaunchFiltersViewPresentingLogic: AnyObject {
  func onApplyFilterSelected()
  func onCancelSelected()
  func onFilterByLaunchSelected(successfulOnly: Bool?)
  func onYearFilterSelected(yearValue: Int?)
  func onSort(byAsscending: String?)
  func onViewLoaded()
}

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
extension LaunchFiltersPresenter: LaunchFiltersViewPresentingLogic {
  func onViewLoaded() {
    displayInitial(filters: activeFilters)
  }
  
  func onYearFilterSelected(yearValue: Int?) {
    activeFilters.launchYear = yearValue
  }
  
  func onFilterByLaunchSelected(successfulOnly: Bool?) {
    activeFilters.launchSuccess = successfulOnly
  }
  
  func onSort(byAsscending: String?) {
    activeFilters.order = byAsscending
  }
  
  func onApplyFilterSelected() {
    router.updateFilterParams(filter: activeFilters)
  }
  
  func onCancelSelected() {
    router.dismiss()
  }
}

// MARK: - Private Methods
private extension LaunchFiltersPresenter {
  func displayInitial(filters: LaunchListFilters) {
    view?.display(sortingRule: filters.order)
    view?.displayFilter(selectedYear: filters.launchYear)
    view?.displayFilter(successfulLaunch: filters.launchSuccess)
  }
}
