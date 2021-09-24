//
//  Decoding-Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public extension JSONDecoder {
  static let `default`: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)
      guard let date = ISO8601DateFormatter.default.date(from: dateStr) else {
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
      }
      return date
    }
    return decoder
  }()
}
