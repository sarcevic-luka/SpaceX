//
//  Globals.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import UIKit

typealias Action = () -> Void
typealias ParametrisedAction<T> = (T) -> Void

// Fixed cell heights
struct CellHeights {
  static var launchListCell: CGFloat = 92
}
