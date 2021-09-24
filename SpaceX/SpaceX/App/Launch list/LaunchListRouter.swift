//
//  LaunchListRouter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LaunchListRoutingLogic: AnyObject { }

protocol LaunchListRouterDelegate: AnyObject { }

class LaunchListRouter {
  weak var viewController: LaunchListViewController?
  weak var delegate: LaunchListRouterDelegate?
  
  static func createModule(delegate: LaunchListRouterDelegate?) -> LaunchListViewController {
    let view = LaunchListViewController(nibName: nil, bundle: nil)
    let interactor = LaunchListInteractor()
    let router = LaunchListRouter()
    router.delegate = delegate
    router.viewController = view
    let presenter = LaunchListPresenter(interface: view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}

// MARK: - LaunchListRoutingLogic
extension LaunchListRouter: LaunchListRoutingLogic { }
