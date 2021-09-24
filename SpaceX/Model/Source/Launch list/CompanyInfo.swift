//
//  CompanyInfo.swift
//  Model
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public struct CompanyInfo {
  public let companyName: String
  public let founderName: String
  public let yearFounded: Int
  public let employeesCount: Int
  public let launchSitesCount: Int
  public let valuation: Int

  private enum CodingKeys: String, CodingKey {
    case companyName = "name"
    case founderName = "founder"
    case yearFounded = "founded"
    case employeesCount = "employees"
    case launchSitesCount = "launch_sites"
    case valuation = "valuation"
  }
}

extension CompanyInfo: Codable { }
