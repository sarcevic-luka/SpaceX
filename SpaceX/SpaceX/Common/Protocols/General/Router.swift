//
//  Router.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import Foundation
import UIKit
import Promises

protocol Router: AnyObject {
  associatedtype ViewController: UIViewController
  var viewController: ViewController? { get }
}

extension Router {
  func showModally(scene: UIViewController) {
    scene.modalPresentationCapturesStatusBarAppearance = true
    scene.modalPresentationStyle = .fullScreen

    if #available(iOS 13.0, *) {
      scene.isModalInPresentation = true
    }

    viewController?.present(scene, animated: true, completion: nil)
  }

  func showAlert(_ alert: AlertViewController, dismissAutomaticallyAfter interval: TimeInterval? = nil, automaticDismissalHandler: Action? = nil) {
    guard let viewController = viewController else { return }
    alert.modalPresentationStyle = .overFullScreen
    alert.modalTransitionStyle = .crossDissolve

    func resolveAlertDismissalIfNeeded() {
      guard interval != nil else { return }
      viewController.dismiss(animated: true, completion: automaticDismissalHandler)
    }

    if let automaticDismissInterval = interval {
      viewController.present(alert, animated: true)
        .delay(automaticDismissInterval)
        .then { viewController.dismiss(animated: true) }
        .then(resolveAlertDismissalIfNeeded)
    } else {
      viewController.present(alert, animated: true)
    }
  }
}
