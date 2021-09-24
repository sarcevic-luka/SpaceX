//
//  DataSourceProtocol.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import Foundation

protocol DataSourceProtocol {
  associatedtype SectionType: SectionProtocol
  var sections: [SectionType] { get }
  var isEmpty: Bool { get }
}

extension DataSourceProtocol {
  var isEmpty: Bool {
    guard numberOfSections() > 0 else {
      return true
    }
    guard sections.first(where: { !$0.items.isEmpty }) != nil else {
      return true
    }
    return false
  }
  
  func numberOfSections() -> Int {
    return sections.count
  }
  
  func numberOfItems(in section: Int) -> Int {
    guard let section = sections[safe: section] else { return 0 }
    return section.isCollapsed ? 0 : section.items.count
  }
  
  func section(at index: Int) -> SectionType? {
    return sections[safe: index]
  }
  
  func item(at indexPath: IndexPath) -> SectionType.Item? {
    return section(at: indexPath.section)?.item(at: indexPath.item)
  }
}

protocol DataBackedDataSourceProtocol: DataSourceProtocol {
  associatedtype Data: Collection
  var rows: Data { get }
  func element(at indexPath: IndexPath) -> Data.Element?
  func element(where: @escaping (Data.Element) -> Bool) -> Data.Element?
}

extension DataBackedDataSourceProtocol where Data.Index == Int {
  func element(at indexPath: IndexPath) -> Data.Element? {
    rows[safe: indexPath.item]
  }
  
  func element(where: @escaping (Data.Element) -> Bool) -> Data.Element? {
    rows.first(where: `where`)
  }
}

extension DataBackedDataSourceProtocol where Data.Index == Int, Data.Element: Equatable {
  /// Retrieves the related index path of a data element within a data source, if the element exists in the data source.
  /// - Parameter element: The element for which the index path is requested.
  /// - Returns: Returns a index path describing the element's position or nil if the element cannot be found within the data source.
  func indexPath(for element: Data.Element) -> IndexPath? {
    guard let indexOf = rows.firstIndex(of: element) else {
      return nil
    }
    return IndexPath(item: indexOf, section: 0)
  }
}
