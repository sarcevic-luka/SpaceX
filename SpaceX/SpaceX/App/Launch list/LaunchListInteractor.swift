//
//  LaunchListInteractor.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Networking
import Model
import Promises

protocol LaunchListBusinessLogic: AnyObject {
  func getAllData(queryParams: LaunchListFilters) -> Promise<([LaunchDetailsItem], CompanyInfo, Int)>
  func getLaunchList(queryParams: LaunchListFilters) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)>
}

class LaunchListInteractor {
  private let launchListNetworkService: LaunchListNetworkServiceProtocol
  
  init(launchListNetworkService: LaunchListNetworkServiceProtocol = LaunchListNetworkService()) {
    self.launchListNetworkService = launchListNetworkService
  }
}

// MARK: - LaunchListBusinessLogic
extension LaunchListInteractor: LaunchListBusinessLogic {
  func getLaunchList(queryParams: LaunchListFilters) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)> {
    getLaunchListDataOnly(queryParams: queryParams)
  }
  
  func getAllData(queryParams: LaunchListFilters) -> Promise<([LaunchDetailsItem], CompanyInfo, Int)> {
    all(getLaunchListDataOnly(queryParams: queryParams), launchListNetworkService.getCompanyInfo())
      .then { (launchDetails, companyInfo) -> Promise<([LaunchDetailsItem], CompanyInfo, Int)> in
        return Promise((launchDetails.launchItems, companyInfo, launchDetails.totalCount))
      }
  }
}

private extension LaunchListInteractor {
  func getLaunchListDataOnly(queryParams: LaunchListFilters) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)> {
    Promise { fullfill, reject in
      self.launchListNetworkService.getLaunchList(queryParams: queryParams)
        .then { (listItems, totalCount) in
          return fullfill((listItems, totalCount))
        }
        .catch { error in
          print(error.localizedDescription)
          reject(error)
        }
    }
  }
}

