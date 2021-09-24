//
//  Globals.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import Foundation

typealias Action = () -> Void
typealias ParametrisedAction<T> = (T) -> Void

func onMainThread(action: Action?) {
  DispatchQueue.main.async { action?() }
}

struct Timings {
  static var shortMessagePopupExpirationInterval: TimeInterval = 2
  static var defaultMessagePopupExpirationInterval: TimeInterval = 3
  static var longMessagePopupExpirationInterval: TimeInterval = 4
}
