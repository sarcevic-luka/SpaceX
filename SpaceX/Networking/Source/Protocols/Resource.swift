//
//  Resource.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

protocol Resource {
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var queryItems: [URLQueryItem] { get }
}

extension Resource {
  var url: URL {
    let baseUrl = Host.base.endpoint.appendingPathComponent(endpoint)
    guard !queryItems.isEmpty else {
      return baseUrl
    }
    return UrlQueryBuilder(url: baseUrl)
      .addQueryItems(queryItems)
      .build() ?? baseUrl
  }
  
  #warning("Check for redundand variables")
  var isAuthorized: Bool { false }
  var method: HTTPMethod { .get }
  var queryItems: [URLQueryItem] { [] }
}
