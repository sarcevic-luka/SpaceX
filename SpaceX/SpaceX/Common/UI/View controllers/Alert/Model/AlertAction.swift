//
//  AlertAction.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import Foundation

struct AlertAction {
  enum Style {
    case `default`
    case preferred
  }

  let title: String
  let style: Style
  let action: Action?

  init(title: String, style: Style = .default, action: Action?) {
    self.title = title
    self.style = style
    self.action = action
  }
}

extension AlertAction {
  static func cancel(action: Action?) -> Self {
    Self(title: "Cancel", style: .default, action: action)
  }

  static func article(action: Action?) -> Self {
    Self(title: "Article", style: .preferred, action: action)
  }
  
  static func wikipedia(action: Action?) -> Self {
    Self(title: "Wikipedia", style: .preferred, action: action)
  }
  
  static func video(action: Action?) -> Self {
    Self(title: "Video", style: .preferred, action: action)
  }
}
