//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Luka Šarčević on 23.09.2021..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
}

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    StartupProcessService()
      .execute(process: AppearanceCustomisationStartupProcess())

    window?.rootViewController = UINavigationController(rootViewController:LaunchListRouter.createModule(delegate: nil))
    window?.makeKeyAndVisible()

    return true
  }
}

