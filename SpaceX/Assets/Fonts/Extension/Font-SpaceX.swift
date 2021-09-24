//
//  Font-SpaceX.swift
//  Assets
//
//  Created by Luka Šarčević on 24.09.2021..
//

import UIKit

public extension UIFont {
  static func appFont(size: CGFloat, weight: FontWeight) -> UIFont {
    return UIFont(name: "SFProDisplay-\(weight.rawValue)", size: size) ?? UIFont.systemFont(ofSize: 14)
  }
    
  enum FontWeight: String, CaseIterable {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
  }
}
