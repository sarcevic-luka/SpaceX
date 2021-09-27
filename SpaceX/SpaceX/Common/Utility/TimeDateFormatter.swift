//
//  TimeDateFormatter.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import Foundation

final class TimeDateFormatter {
  enum DateFormat: String {
    case dateAndTime = "dd.MM.yyyy 'at' HH:mm"
  }

  private static var dateFormatter = DateFormatter()
}

extension TimeDateFormatter {
  func string(from date: Date, using format: DateFormat) -> String {
    Self.dateFormatter.dateFormat = format.rawValue
    return Self.dateFormatter.string(from: date)
  }
}
