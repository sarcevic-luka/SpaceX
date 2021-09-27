//
//  LaunchListHeaderModel.swift
//  Model
//
//  Created by Luka Šarčević on 26.09.2021..
//

import Foundation

public struct LaunchListHeaderModel {
  public let totalCount: String

  
  private enum CodingKeys: String, CodingKey {
    case totalCount = "spacex-api-count"
  }
}

extension LaunchListHeaderModel: Codable { }
