//
//  UIView-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit

public extension UIView {
  func fadeIn(_ duration: TimeInterval = 0.6) {
    fadeTo(1.0, duration: duration)
  }
  
  func fadeOut(_ duration: TimeInterval = 0.6) {
    fadeTo(0.0, duration: duration)
  }
  
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 10.0, -2.5, 2.5, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}

private extension UIView {
  func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: duration) {
        self.alpha = alpha
      }
    }
  }
}
