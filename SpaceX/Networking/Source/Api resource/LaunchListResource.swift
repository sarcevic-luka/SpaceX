//
//  LaunchListResource.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Model
import Alamofire

public enum LaunchListResource: Resource {
  case getLaunchList(params: LaunchListFilters)
  case getCompanyInfo
  
  var endpoint: String {
    switch self {
    case .getLaunchList:
      return "launches"
    case .getCompanyInfo:
      return "info"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getLaunchList, .getCompanyInfo:
      return .get
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .getLaunchList(let params):
      var queryItems = [URLQueryItem]()
      queryItems.append(URLQueryItem(name: "offset", value: params.offset.description))
      queryItems.append(URLQueryItem(name: "limit", value: params.limit.description))
      queryItems.append(URLQueryItem(name: "launch_year", value: params.launchYear?.description))
      queryItems.append(URLQueryItem(name: "launch_success", value: params.launchSuccess?.description))
      queryItems.append(URLQueryItem(name: "order", value: params.order?.description))
      return queryItems
    case .getCompanyInfo:
      return []
    }
  }
}
