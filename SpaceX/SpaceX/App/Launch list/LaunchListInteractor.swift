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
  func getAllData() -> Promise<([LaunchDetailsItem], CompanyInfo, Int)>
  func getLaunchList(offset: Int) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)>
}

class LaunchListInteractor {
  private let paginationLimit = 25
  private let launchListNetworkService: LaunchListNetworkServiceProtocol
  
  init(launchListNetworkService: LaunchListNetworkServiceProtocol = LaunchListNetworkService()) {
    self.launchListNetworkService = launchListNetworkService
  }
}

// MARK: - LaunchListBusinessLogic
extension LaunchListInteractor: LaunchListBusinessLogic {
  func getAllData() -> Promise<([LaunchDetailsItem], CompanyInfo, Int)> {
    all(getLaunchListDataOnly(offset: 0), launchListNetworkService.getCompanyInfo())
      .then { (launchDetails, companyInfo) -> Promise<([LaunchDetailsItem], CompanyInfo, Int)> in
        return Promise((launchDetails.launchItems, companyInfo, launchDetails.totalCount))
      }
  }
  
  func getLaunchList(offset: Int) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)> {
    getLaunchListDataOnly(offset: offset)
  }
}

private extension LaunchListInteractor {
  func getLaunchListDataOnly(offset: Int) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)> {
    Promise { fullfill, reject in
      self.launchListNetworkService.getLaunchList(offset: offset, limit: self.paginationLimit)
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
