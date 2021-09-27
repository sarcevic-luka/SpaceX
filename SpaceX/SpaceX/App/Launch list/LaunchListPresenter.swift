//
//  LaunchListPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Model

protocol LaunchListViewPresentingLogic: AnyObject {
  func onItemSelected(at indexPath: IndexPath)
  func onFilterButtonTapped()
  func onPrefetchRequested()
  func refreshControlValueChanged()
  func onViewDidLoad()
}

class LaunchListPresenter {
  var interactor: LaunchListBusinessLogic?
  weak private var view: LaunchListDisplayLogic?
  private var dataSource: LaunchListDataSource?
  private var isFetchInProgress = false
  private let router: LaunchListRoutingLogic
  
  init(interface: LaunchListDisplayLogic, interactor: LaunchListBusinessLogic?, router: LaunchListRoutingLogic) {
    self.view = interface
    self.interactor = interactor
    self.router = router
  }
}

// MARK: - LaunchListViewPresentingLogic
extension LaunchListPresenter: LaunchListViewPresentingLogic {
  func onItemSelected(at indexPath: IndexPath) {
    guard let details = dataSource?.launchDetails(at: indexPath.row) else { return }
    router.showLaunchDetails(for: details)
  }
  
  func onFilterButtonTapped() {
    guard let activeFilters = dataSource?.queryParams else { return }
    router.showFilterSelection(with: activeFilters)
  }

  func onPrefetchRequested() {
    if isFetchInProgress { return }
    isFetchInProgress = true
    guard let params = dataSource?.queryParams else { return }
    interactor?.getLaunchList(queryParams: params)
      .then { [weak self] (launchList, totalCount) in
        onMainThread {
          guard let strongSelf = self else { return }
          strongSelf.dataSource?.setLaunchList(launchList)
          strongSelf.view?.displayLaunchList(totalCount: totalCount, companyInfo: nil, launchListItems: launchList)
          return
        }
      }
      .catch { [weak self] error in
          #warning("Add message display")
        print(error.localizedDescription)
        //        self?.view?.displayMessagePopup(with: .customError(error.localizedDescription))
      }
      .always { [weak self] in
        self?.isFetchInProgress = false
      }
  }
  
  func refreshControlValueChanged() {
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
    interactor?.getAllData()
      .then { [weak self] (launchList, companyInfo, totalCount) in
        guard let strongSelf = self else { return }
        strongSelf.dataSource = LaunchListDataSource(totalCount: totalCount, companyInfo: companyInfo, launchListItems: launchList)
        strongSelf.view?.displayLaunchList(totalCount: totalCount, companyInfo: companyInfo, launchListItems: launchList)
        return
      }
      .catch { [weak self] error in
#warning("Add message display")
        //        self?.view?.displayMessagePopup(with: .customError(error.localizedDescription))
      }
      .always { [weak self] in
        self?.isFetchInProgress = false
      }
  }
}
