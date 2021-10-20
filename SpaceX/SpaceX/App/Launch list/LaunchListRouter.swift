//
//  LaunchListRouter.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SafariServices
import Model
import Promises

protocol LaunchListRoutingLogic: AnyObject {
  func showFilterSelection(with filters: LaunchListFilters)
  func showLaunchDetails(for launch: LaunchDetailsItem)
}

protocol LaunchListRouterDelegate: AnyObject {
  func launchDetailsRequested(action: AlertAction.LaunchList)
}

class LaunchListRouter: Router {
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
extension LaunchListRouter: LaunchListRoutingLogic {
  func showFilterSelection(with filters: LaunchListFilters) {
    let activeFilter = filters
    activeFilter.offset = 0
    let filtersScene = LaunchFiltersRouter.createModule(activeFilters: activeFilter, delegate: self)
    viewController?.present(filtersScene, animated: true)
  }
  
  func showLaunchDetails(for launch: LaunchDetailsItem) {
    showAlert(.launchDetails(
      title: launch.missionName,
      articleHandler: { [weak self] in
        self?.viewController?
          .dismiss(animated: true)
          .then { [weak self] in
            self?.open(launchURL: launch.links.articleLink)
          }
      },
      videoHandler: { [weak self] in
        self?.viewController?
          .dismiss(animated: true)
          .then { [weak self] in
            self?.open(launchURL: launch.links.videoLink)
          }
      },
      wikiHandler: { [weak self] in
        self?.viewController?
          .dismiss(animated: true)
          .then { [weak self] in
            self?.open(launchURL: launch.links.wikipediaLink)
          }
      }, cancelHandler: { [weak self] in
        self?.viewController?
          .dismiss(animated: true)
      }))
  }
}

private extension LaunchListRouter {
  func open(launchURL: URL?) {
    if let url = launchURL {
      let config = SFSafariViewController.Configuration()
      config.entersReaderIfAvailable = true
      let vc = SFSafariViewController(url: url, configuration: config)
      viewController?.present(vc, animated: true)
    }
  }
}

extension LaunchListRouter: LaunchFiltersRouterDelegate {
  func launchFiltersRouterRequestedDismissal() {
    viewController?.dismiss(animated: true)
  }
  
  func applyFilter(filter: LaunchListFilters) {
    viewController?.dismiss(animated: true, completion: { [weak self] in
      self?.viewController?.reloadData(with: filter)
    })
  }
}
