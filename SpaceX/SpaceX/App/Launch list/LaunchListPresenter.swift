//
//  LaunchListPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Model
import Promises

protocol LaunchListViewPresentingLogic: AnyObject {
  func onItemSelected(at indexPath: IndexPath)
  func onFilterButtonTapped()
  func onFetchFreshLaunchList(filters: LaunchListFilters)
  func onPrefetchRequested()
  func onRefreshControlValueChanged()
  func onViewDidLoad()
}

class LaunchListPresenter {
  var interactor: LaunchListBusinessLogic?
  weak private var view: LaunchListDisplayLogic?
  private var dataSource: LaunchListDataSource?
  private var queryParams: LaunchListFilters
  private var isFetchInProgress = false
  private let router: LaunchListRoutingLogic
  
  init(interface: LaunchListDisplayLogic, interactor: LaunchListBusinessLogic?, router: LaunchListRoutingLogic) {
    self.view = interface
    self.interactor = interactor
    self.router = router
    self.queryParams = LaunchListFilters(offset: 0, limit: 15)
  }
}

// MARK: - LaunchListViewPresentingLogic
extension LaunchListPresenter: LaunchListViewPresentingLogic {
  func onItemSelected(at indexPath: IndexPath) {
    guard let details = dataSource?.launchDetails(at: indexPath.row) else { return }
    router.showLaunchDetails(for: details)
  }
  
  func onFilterButtonTapped() {
    router.showFilterSelection(with: queryParams)
  }
  
  func onFetchFreshLaunchList(filters: LaunchListFilters) {
    queryParams = filters
    fetchAndPresentLaunchList()
  }
  
  func onPrefetchRequested() {
    if isFetchInProgress { return }
    queryParams.offset = dataSource?.currentOffset() ?? 0
    isFetchInProgress = true
    interactor?.getLaunchList(queryParams: queryParams)
      .then { [weak self] (launchList, totalCount) in
        onMainThread {
          guard let strongSelf = self else { return }
          strongSelf.dataSource?.setLaunchList(launchList, totalCount: totalCount)
          strongSelf.view?.displayPaginatedLaunchListItems(launchListItems: launchList, totalCount: totalCount)
          return
        }
      }
      .catch { [weak self] error in
        self?.view?.displayMessagePopup(with: .customError(error.localizedDescription))
      }
      .always { [weak self] in
        self?.isFetchInProgress = false
      }
  }
  
  func onRefreshControlValueChanged() {
    fetchAndPresentLaunchList()
  }
  
  func onViewDidLoad() {
    fetchAndPresentLaunchList()
  }
}

private extension LaunchListPresenter {
  func fetchAndPresentLaunchList() {
    if isFetchInProgress { return }
    isFetchInProgress = true
    
    interactor?.getAllData(queryParams: queryParams)
      .then { [weak self] (launchList, companyInfo, totalCount) in
        guard let strongSelf = self else { return }
        strongSelf.dataSource = nil
        strongSelf.dataSource?.clearList()
        strongSelf.dataSource = LaunchListDataSource(totalCount: totalCount, companyInfo: companyInfo, launchListItems: launchList)
        strongSelf.view?.displayLaunchList(totalCount: totalCount, companyInfo: companyInfo, launchListItems: launchList)
        return
      }
      .catch { [weak self] error in
        self?.view?.displayMessagePopup(with: .customError(error.localizedDescription))
      }
      .always { [weak self] in
        self?.isFetchInProgress = false
      }
  }
}
