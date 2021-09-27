//
//  UIViewController-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Promises

extension UIViewController {
  @discardableResult
  func present(_ viewController: UIViewController, animated: Bool) -> Promise<Void> {
    Promise { fullfill, _ in
      self.present(viewController, animated: animated) { fullfill(()) }
    }
  }
  
  @discardableResult
  func dismiss(animated: Bool) -> Promise<Void> {
    Promise { fullfill, _ in
      self.dismiss(animated: animated) { fullfill(()) }
    }
  }
}
