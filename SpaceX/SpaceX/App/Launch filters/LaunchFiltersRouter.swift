//
//  LaunchFiltersRouter.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Model

protocol LaunchFiltersRoutingLogic: AnyObject { }

protocol LaunchFiltersRouterDelegate: AnyObject { }

class LaunchFiltersRouter {
  weak var viewController: LaunchFiltersViewController?
  weak var delegate: LaunchFiltersRouterDelegate?
  
  static func createModule(activeFilters: LaunchListFilters, delegate: LaunchFiltersRouterDelegate?) -> LaunchFiltersViewController {
    let view = LaunchFiltersViewController(nibName: nil, bundle: nil)
    let interactor = LaunchFiltersInteractor()
    let router = LaunchFiltersRouter()
    router.delegate = delegate
    router.viewController = view
    let presenter = LaunchFiltersPresenter(activeFilters: activeFilters, interface: view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}

// MARK: - LaunchFiltersRoutingLogic
extension LaunchFiltersRouter: LaunchFiltersRoutingLogic { }
