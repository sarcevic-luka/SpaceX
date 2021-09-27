//
//  UIAplication-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import UIKit

extension UIApplication {
  static var app: AppDelegate {
    shared.delegate as! AppDelegate
  }
  var focusedWindow: UIWindow? { Self.shared.windows.first(where: { $0.isKeyWindow }) }
}
