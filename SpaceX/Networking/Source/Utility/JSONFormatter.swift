//
//  JSONFormatter.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation

public extension ISO8601DateFormatter {
  static let `default`: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = TimeZone.current
    if #available(iOS 11.0, *) {
      formatter.formatOptions = [.withFractionalSeconds, .withTimeZone, .withInternetDateTime]
    } else {
      formatter.formatOptions = [.withTimeZone, .withInternetDateTime]
    }
    return formatter
  }()
}
