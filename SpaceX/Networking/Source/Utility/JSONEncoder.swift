//
//  JSONEncoder.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public extension JSONEncoder {
  static let `default`: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .custom { date, encoder in
      var container = encoder.singleValueContainer()
      try container.encode(ISO8601DateFormatter.default.string(from: date))
    }
    #if DEBUG
    encoder.outputFormatting = .prettyPrinted
    #endif
    return encoder
  }()
}
