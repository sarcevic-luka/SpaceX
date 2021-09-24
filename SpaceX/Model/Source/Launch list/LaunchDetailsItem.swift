//
//  LaunchDetailsItem.swift
//  Model
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public struct LaunchDetailsItem {
  public let missionName: String
  public let launchDate: String
  public let launchedSuccessfully: Bool
  public let rocket: RocketDetails
  public let links: LinkDetails
  
  private enum CodingKeys: String, CodingKey {
    case missionName = "mission_name"
    case launchDate = "launch_date_utc"
    case launchedSuccessfully = "launch_success"
    case rocket
    case links
  }
}

extension LaunchDetailsItem: Codable { }
