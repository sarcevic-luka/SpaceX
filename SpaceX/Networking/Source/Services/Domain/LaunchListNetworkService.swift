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
  func getLaunchList(offset: Int, limit: Int) -> Promise<[LaunchDetailsItem]>
  func getCompanyInfo() -> Promise<CompanyInfo>
}

public final class LaunchListNetworkService {
  public init() { }
}

extension LaunchListNetworkService: LaunchListNetworkServiceProtocol {
  public func getLaunchList(offset: Int, limit: Int) -> Promise<[LaunchDetailsItem]> {
    Promise { fullfill, reject in
      Networking.session
        .request(resource: LaunchListResource.getLaunchList(offset: offset, limit: limit))
        .validate()
        .responseDecodable(decoder: JSONDecoder.default) { (response: DataResponse<[LaunchDetailsItem], AFError>) in
          switch response.result {
          case .success(let data):
            fullfill(data)
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
