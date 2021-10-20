//
//  LaunchListNetworkService.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Model
import Promises
import Alamofire

public protocol LaunchListNetworkServiceProtocol {
  func getLaunchList(queryParams: LaunchListFilters) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)>
  func getCompanyInfo() -> Promise<CompanyInfo>
}

public final class LaunchListNetworkService {
  public init() { }
}

extension LaunchListNetworkService: LaunchListNetworkServiceProtocol {
  public func getLaunchList(queryParams: LaunchListFilters) -> Promise<(launchItems: [LaunchDetailsItem], totalCount: Int)> {
    Promise { fullfill, reject in
      Networking.session
        .request(resource: LaunchListResource.getLaunchList(params: queryParams))
        .validate()
        .responseDecodable(decoder: JSONDecoder.default) { (response: DataResponse<[LaunchDetailsItem], AFError>) in
          switch response.result {
          case .success(let data):
            do {
              let jsonData = try JSONSerialization.data(withJSONObject: response.response?.allHeaderFields as Any, options: .prettyPrinted)
              let headerModel = try JSONDecoder().decode(LaunchListHeaderModel.self, from: jsonData)
              let totalCount: Int = Int(headerModel.totalCount) ?? 0
              fullfill((launchItems: data, totalCount: totalCount))
            } catch {
              reject(error)
            }
          case .failure(let error):
            reject(error)
          }
        }
    }
  }
  
  public func getCompanyInfo() -> Promise<CompanyInfo> {
    Promise { fullfill, reject in
      Networking.session
        .request(resource: LaunchListResource.getCompanyInfo)
        .validate()
        .responseDecodable(decoder: JSONDecoder.default) { (response: DataResponse<CompanyInfo, AFError>) in
          switch response.result {
          case .success(let data):
            fullfill(data)
          case .failure(let error):
            reject(error)
          }
        }
    }
  }
}
