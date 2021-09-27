//
//  LaunchListViewController.swift
//  SpaceX
//
//  Created Luka Šarčević on 25.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Model

protocol LaunchListDisplayLogic: AnyObject {
  func displayLaunchList(totalCount: Int, companyInfo: CompanyInfo, launchListItems: [LaunchDetailsItem])
  func displayPaginatedLaunchListItems(launchListItems: [LaunchDetailsItem], totalCount: Int)
}

class LaunchListViewController: UIViewController {
  var presenter: LaunchListViewPresentingLogic?
  private var dataSource: LaunchListDataSource?
  private lazy var contentView = LaunchListContentView()
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    presenter?.onViewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
}

// MARK: - LaunchListDisplayLogic
extension LaunchListViewController: LaunchListDisplayLogic {
  func displayLaunchList(totalCount: Int, companyInfo: CompanyInfo, launchListItems: [LaunchDetailsItem]) {
    onMainThread {
      self.dataSource?.clearList()
      self.dataSource = LaunchListDataSource(totalCount: totalCount, companyInfo: companyInfo, launchListItems: launchListItems)
      self.contentView.tableView.reloadData()
      self.contentView.tableView.refreshControl?.endRefreshing()
    }
  }
  
  func displayPaginatedLaunchListItems(launchListItems: [LaunchDetailsItem], totalCount: Int) {
    onMainThread {
      self.dataSource?.setLaunchList(launchListItems, totalCount: totalCount)
      guard let indexPathsForReload = self.dataSource?.calculateIndexPathsToReload(from: launchListItems) else {
        return
      }
      self.contentView.tableView.refreshControl?.endRefreshing()
      self.contentView.tableView.reloadRows(at: indexPathsForReload, with: .automatic)
    }
  }
  
  func reloadData(with filters: LaunchListFilters) {
    presenter?.onFetchFreshLaunchList(filters: filters)
  }
}

private extension LaunchListViewController {
  @objc func filterButtonTapped() {
    presenter?.onFilterButtonTapped()
  }
}

private extension LaunchListViewController {
  func setupView() {
    setupContentView()
    setupTableView()
  }
  
  func setupContentView() {
    contentView.refreshControlRefreshHandler = { [weak self] in
      self?.presenter?.onRefreshControlValueChanged()
    }
  }
  
  func setupTableView() {
    contentView.tableView.dataSource = self
    contentView.tableView.delegate = self
    contentView.tableView.prefetchDataSource = self
    contentView.tableView.isPrefetchingEnabled = true
  }
  
  func setupNavigationBar() {
    navigationItem.title = "SpaceX"
    navigationItem.rightBarButtonItem = .filterButton(target: self, action: #selector(filterButtonTapped))
  }
}

extension LaunchListViewController: UITableViewDataSource  {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource?.numberOfSections() ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return dataSource?.totalCount ?? 0
    }
    return dataSource?.numberOfItems(in: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let item = dataSource?.item(at: indexPath) else {
      return UITableViewCell()
    }
    
    switch item {
    case .info(let infoModel):
      let cell = tableView.dequeueReusableCell(LaunchListCompanyInfoCell.self, at: indexPath)
      cell.update(infoModel)
      return cell
    case .launchList(let listModel):
      let cell = tableView.dequeueReusableCell(LaunchListCell.self, at: indexPath)
      if isLoadingCell(for: indexPath) {
        cell.update(nil)
      } else {
        cell.update(listModel)
      }
      return cell
    }
  }
}

extension LaunchListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let listSection = dataSource?.section(at: section) else { return UIView() }
    let header = tableView.dequeueReusableHeaderFooterView(HeaderView.self)
    switch listSection {
    case .launchList(let title, _), .info(let title, _):
      header.titleText = title
    }
    return header
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.onItemSelected(at: indexPath)
  }
}

extension LaunchListViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      presenter?.onPrefetchRequested()
    }
  }
}

// MARK: - Utility methods
private extension LaunchListViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    indexPath.row >= dataSource?.currentOffset() ?? 0
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = contentView.tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
