//
//  ImageAssets.swift
//  Assets
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public struct ImageAssets { }

public extension ImageAssets {
  enum Icons: String, ImageAsset {
    case failure = "icn_failure"
    case filter = "icn_filter"
    case shuttle = "icn_shuttle"
    case success = "icn_success"
  }
  
  enum Images: String, ImageAsset {
    case appLogo = "img_app_logo"
  }
}
