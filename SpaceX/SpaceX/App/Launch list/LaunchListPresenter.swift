//
//  LaunchListPresenter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol LaunchListViewPresentingLogic: AnyObject {
  func onItemSelected(at indexPath: IndexPath)
  func onPrefetchRequested()
  func onRefreshControlRefresh()
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
#warning("Add logic here")
  }
  
  func onPrefetchRequested() {
    if isFetchInProgress { return }
    isFetchInProgress = true
    interactor?.getLaunchList(offset: dataSource?.currentOffset() ?? 0)
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
  
  func onRefreshControlRefresh() {
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
