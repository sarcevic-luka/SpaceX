//
//  UIBarButton-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Assets

extension UIBarButtonItem {
  static func filterButton(target: Any, action: Selector) -> UIBarButtonItem {
    UIBarButtonItem(
      image: ImageAssets.Icons.filter.image.withTintColor(.black),
      style: .done,
      target: target,
      action: action
    )
  }
}
