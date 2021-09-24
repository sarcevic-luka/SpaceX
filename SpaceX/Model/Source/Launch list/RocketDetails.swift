//
//  RocketDetails.swift
//  Model
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public struct RocketDetails {
  public let rocketName: String
  public let rocketType: String
  
  private enum CodingKeys: String, CodingKey {
    case rocketName = "rocket_name"
    case rocketType = "rocket_type"
  }
}

extension RocketDetails: Codable { }
