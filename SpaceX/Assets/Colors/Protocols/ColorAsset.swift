//
//  ColorAsset.swift
//  Assets
//
//  Created by Luka Šarčević on 24.09.2021..
//

import UIKit

public protocol ColorAsset: Asset {
  var color: UIColor { get }
}

public extension ColorAsset where Self: RawRepresentable, RawValue == String {
  var name: String {
    rawValue
  }
  
  var color: UIColor {
    UIColor(named: rawValue) ?? .black
  }
}
