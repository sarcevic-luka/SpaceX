//
//  StartupProcess.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import Foundation

/// An abstraction for a predefined set of functionality, aimed to be ran once, at app startup.
public protocol StartupProcess {
  func run(completion: @escaping (Bool) -> Void)
}
