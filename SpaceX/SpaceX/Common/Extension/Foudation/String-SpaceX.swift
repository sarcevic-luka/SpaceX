//
//  String-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import Foundation

extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
