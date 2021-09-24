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
    UINavigationBar.appearance().barTintColor = ColorAssets.General.appBlack.color
    let titleFont: UIFont = .appFont(size: 24, weight: .bold)
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = ColorAssets.General.appBlack.color
    appearance.titleTextAttributes = [
      NSAttributedString.Key.font: titleFont,
      NSAttributedString.Key.foregroundColor: ColorAssets.General.appWhite.color
    ]
    UINavigationBar.appearance().standardAppearance = appearance
  }
}
