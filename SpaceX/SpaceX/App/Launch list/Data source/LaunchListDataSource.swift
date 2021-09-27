//
//  LaunchListDataSource.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit
import Model

enum LaunchListDataSourceItem {
  case info(LaunchListCompanyInfoCell.ViewModel)
  case launchList(LaunchListCell.ViewModel)
}

enum LaunchListDataSourceSection: SectionProtocol {
  case info(String, LaunchListDataSourceItem)
  case launchList(String, [LaunchListDataSourceItem])

  var items: [LaunchListDataSourceItem] {
    switch self {
    case .info(_, let item):
      return [item]
    case .launchList(_, let items):
      return items
    }
  }
}

class LaunchListDataSource: DataSourceProtocol {
  var totalCount: Int
  var queryParams: LaunchListFilters
  private var companyInfo: CompanyInfo?
  private var launchListItems: [LaunchDetailsItem]
  private let dateFormatter = TimeDateFormatter()

  private(set) lazy var sections = [LaunchListDataSourceSection]()
  
  init(totalCount: Int, companyInfo: CompanyInfo?, launchListItems: [LaunchDetailsItem]) {
    self.totalCount = totalCount
    self.companyInfo = companyInfo
    self.launchListItems = launchListItems
    self.queryParams = LaunchListFilters(offset: 0, limit: 25)
    buildSections()
  }
}

extension LaunchListDataSource {
  func buildSections() {
    sections.removeAll()
    if let infoSection = createInfoSection() {
      sections.append(infoSection)
    }
    if let launchListSection = createLaunchListSection() {
      sections.append(launchListSection)
    }
  }
  
  func launchDetails(at index: Int) -> LaunchDetailsItem? {
   return launchListItems[index]
  }
}

// MARK: - LaunchListDataSourceSection creation
private extension LaunchListDataSource {
  func createInfoSection() -> LaunchListDataSourceSection? {
    guard let info = companyInfo else { return nil }
    return .info("Company".uppercased(), createInfoItem(with: info))
  }

  func createLaunchListSection() -> LaunchListDataSourceSection? {
    guard !launchListItems.isEmpty else { return nil }
    return .launchList("Launches".uppercased(), launchListItems.map { createLaunchListSection(with: $0) })
  }
}

// MARK: - LaunchListDataSourceItem creation
private extension LaunchListDataSource {
  func createInfoItem(with info: CompanyInfo) -> LaunchListDataSourceItem {
    return .info(LaunchListCompanyInfoCell.ViewModel(info: "\(info.companyName) was founded by \(info.founderName) in \(info.yearFounded). It has now \(info.employeesCount) employees, \(info.launchSitesCount) launch sites, and is valued at USD \(info.valuation)"))
  }

  func createLaunchListSection(with launchItem: LaunchDetailsItem) -> LaunchListDataSourceItem {
    .launchList(LaunchListCell.ViewModel(missionIconURL: launchItem.links.missionBanner,
                                         missionName: launchItem.missionName,
                                         missionTime: date(from: launchItem.launchDate),
                                         rocketDetails: "\(launchItem.rocket.rocketName) / \(launchItem.rocket.rocketType)",
                                         daysCount: days(since: launchItem.launchDate),
                                         launchWasSuccessful: launchItem.launchedSuccessfully ?? false))
  }
}

//// MARK: - Pagination
extension LaunchListDataSource {
  func setLaunchList(_ newLaunchListBatch: [LaunchDetailsItem]) {
    launchListItems.append(contentsOf: newLaunchListBatch)
    buildSections()
  }

  func calculateIndexPathsToReload(from newLaunchListBatch: [LaunchDetailsItem]) -> [IndexPath] {
    let startIndex = currentOffset() 
    let endIndex = startIndex + newLaunchListBatch.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 1) }
  }

  func currentOffset() -> Int {
    launchListItems.count 
  }
}

//// MARK: - Date formater utility
private extension LaunchListDataSource {
  func date(from dateString: Double) -> String {
    let startDate = Date(timeIntervalSince1970: TimeInterval(dateString))
    return dateFormatter.string(from: startDate, using: .dateAndTime)
  }
  
  func days(since dateString: Double) -> Int {
    let startDate = Date(timeIntervalSince1970: TimeInterval(dateString))
    let components = Calendar.current.dateComponents([.day], from: startDate, to: Date())
    return components.day ?? 0
  }
}
