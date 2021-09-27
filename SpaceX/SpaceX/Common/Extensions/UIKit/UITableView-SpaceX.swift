//
//  UITableView-SpaceX.swift
//  SpaceX
//
//  Created by Luka Šarčević on 25.09.2021..
//

import UIKit

public extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) {
    register(T.self, forCellReuseIdentifier: T.identifier)
  }
  
  func register<T: UITableViewHeaderFooterView>(_: T.Type) {
    register(T.self, forHeaderFooterViewReuseIdentifier: T.identifier)
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooter: T.Type) -> T {
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
      debugPrint("Could not dequeue headerFooter view with identifier: \(T.identifier)")
      return T()
    }
    return view
  }

  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.identifier)")
    }
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      debugPrint("Could not dequeue cell with identifier: \(T.identifier). Creating new instance.")
      return T()
    }
    return cell
  }
}
public extension UITableViewCell {
  /// Returns cell's reuse identifier
  static var identifier: String {
    return String(describing: self)
  }
}

public extension UITableViewHeaderFooterView {
  /// Returns cell's reuse identifier
  static var identifier: String {
    return String(describing: self)
  }
}
