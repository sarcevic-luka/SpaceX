//
//  AlertViewController-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit

// MARK: - General
extension AlertViewController {
  static func launchDetails(title: String, articleHandler: Action?, videoHandler: Action?, wikiHandler: Action?, cancelHandler: Action?) -> AlertViewController {
    AlertViewController(title: title,
                        message: "For more details \n please select source below:",
                        actions: [.article(action: articleHandler), .video(action: videoHandler), .wikipedia(action: wikiHandler), .cancel(action: cancelHandler)])
  }
}
