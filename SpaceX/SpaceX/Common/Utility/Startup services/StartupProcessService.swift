//
//  StartupProcessService.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import Foundation

public final class StartupProcessService {
  public init() { }

  @discardableResult
  public func execute(process: StartupProcess) -> StartupProcessService {
    process.run { guard $0 else { return } }
    return self
  }
}
