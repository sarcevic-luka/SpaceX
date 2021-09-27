//
//  LinkDetails.swift
//  Model
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public struct LinkDetails {
  public let missionBanner: URL?
  public let articleLink: URL?
  public let wikipediaLink: URL?
  public let youtubeLink: URL?
  
  private enum CodingKeys: String, CodingKey {
    case missionBanner = "mission_patch_small"
    case articleLink = "article_link"
    case wikipediaLink = "wikipedia"
    case youtubeLink = "video_link"
  }
}

extension LinkDetails: Codable { }
