//
//  ColorAssets.swift
//  Assets
//
//  Created by Luka Šarčević on 24.09.2021..
//

import UIKit

public struct ColorAssets { }

public extension ColorAssets {
  enum General: String, ColorAsset {
    case appBlack = "color_app_black"
    case gray = "color_gray"
    case white = "color_white"
    
    public var color: UIColor {
      UIColor(named: rawValue, in: Bundle(for: ColorDummy.self), compatibleWith: nil) ?? .black
    }
  }
}
