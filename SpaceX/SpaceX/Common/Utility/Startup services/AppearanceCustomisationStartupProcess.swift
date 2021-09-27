//
//  AppearanceCustomisationStartupProcess.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import UIKit
import Assets

final class AppearanceCustomisationStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    setupNavigationBarAppearance()
    completion(true)
  }
}

private extension AppearanceCustomisationStartupProcess {
  func setupNavigationBarAppearance() {
    let titleFont: UIFont = .appFont(size: 20, weight: .medium)
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = ColorAssets.General.white.color
    appearance.titleTextAttributes = [
      NSAttributedString.Key.font: titleFont,
      NSAttributedString.Key.foregroundColor: ColorAssets.General.appBlack.color
    ]
    UINavigationBar.appearance().standardAppearance = appearance
  }
}
