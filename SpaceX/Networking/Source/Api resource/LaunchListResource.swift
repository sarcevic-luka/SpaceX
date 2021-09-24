//
//  LaunchListResource.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

public enum LaunchListResource: Resource {
  case getLaunchList(offset: Int, limit: Int)
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
    case .getLaunchList(let offset, let limit):
      var queryItems = [URLQueryItem]()
      queryItems.append(URLQueryItem(name: "offset", value: offset.description))
      queryItems.append(URLQueryItem(name: "limit", value: limit.description))
      return queryItems
    case .getCompanyInfo:
      return []
    }
  }
}
