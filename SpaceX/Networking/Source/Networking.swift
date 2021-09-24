//
//  Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

public final class Networking {
  internal static let session = Alamofire.Session(eventMonitors: [NetworkEventMonitor()])
}
