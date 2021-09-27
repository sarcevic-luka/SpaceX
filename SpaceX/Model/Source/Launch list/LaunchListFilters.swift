//
//  LaunchListGetParams.swift
//  Model
//
//  Created by Luka Šarčević on 27.09.2021..
//

import Foundation

public class LaunchListFilters {
  public let offset: Int
  public let limit: Int
  public let launchYear: Int?
  public let launchSuccess: Bool?
  public let order: String?

  public init(offset: Int, limit: Int, launchYear: Int? = nil, launchSuccess: Bool? = nil, order: String? = "") {
    self.offset = offset
    self.limit = limit
    self.launchYear = launchYear
    self.launchSuccess = launchSuccess
    self.order = order
  }
}

extension LaunchListFilters: Encodable { }
