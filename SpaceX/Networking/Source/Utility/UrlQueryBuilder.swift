//
//  UrlQueryBuilder.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

/**
 A utility type to ease creating URLs with query parameters.
 
 To add new keys, simply extend UrlQueryBuilder.QueryKey where needed and
 add your new keys as "static let" properties.
  
 extension UrlQueryBuilder.QueryKey {
 static let newKey = "newKey"
 }
 */
public final class UrlQueryBuilder {
  public typealias QueryKey = String
  private let url: URL
  private lazy var queryItems = [URLQueryItem]()

  public init(url: URL) {
    self.url = url
  }
}

public extension UrlQueryBuilder {
  func addQueryItem(queryKey: QueryKey, value: String?) -> Self {
    queryItems.append(URLQueryItem(name: queryKey, value: value))
    return self
  }

  func addQueryItems(_ items: [URLQueryItem]) -> Self {
    queryItems += items
    return self
  }

  func build() -> URL? {
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    return components.url
  }
}
