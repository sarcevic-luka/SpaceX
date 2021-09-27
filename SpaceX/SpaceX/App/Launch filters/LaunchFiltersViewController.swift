//
//  LaunchFiltersViewController.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Model

protocol LaunchFiltersDisplayLogic: AnyObject {
  func displayFilter(selectedYear: Int?)
  func displayFilter(successfulLaunch: Bool?)
  func display(sortingRule: String?)
}

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
    presenter?.onViewLoaded()
  }
}

// MARK: - LaunchFiltersDisplayLogic
extension LaunchFiltersViewController: LaunchFiltersDisplayLogic {
  func displayFilter(selectedYear: Int?) {
    contentView.setOnSelectedFilter(with: selectedYear)
  }
  
  func displayFilter(successfulLaunch: Bool?) {
    contentView.setOnFilter(succesfulLaunch: successfulLaunch)
  }
  
  func display(sortingRule: String?) {
    contentView.setCurrent(sortingRule: sortingRule)
  }
}

private extension LaunchFiltersViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    contentView.yearsSliderHandler = { [weak self] selectedYear in
      self?.presenter?.onYearFilterSelected(yearValue: selectedYear)
    }
    contentView.filterBySuccessfulLaunch = { [weak self] filterSuccessfull in
      self?.presenter?.onFilterByLaunchSelected(successfulOnly: filterSuccessfull)
    }
    contentView.sortByAscending = { [weak self] sortCriteria in
      self?.presenter?.onSort(byAsscending: sortCriteria)
    }
    contentView.applyFilterTapHandler = { [weak self] in
      self?.presenter?.onApplyFilterSelected()
    }
    contentView.cancelTapHandler = { [weak self] in
      self?.presenter?.onCancelSelected()
    }
  }
}
