//
//  Host.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

enum Host: String {
  case base = "https://api.spacexdata.com/v3/"
}

extension Host {
  var endpoint: URL {
    URL(string: self.rawValue)!
  }
}
