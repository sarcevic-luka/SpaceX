//
//  ImageAsset.swift
//  Assets
//
//  Created by Luka Šarčević on 24.09.2021..
//

import UIKit

public protocol ImageAsset: Asset {
  var image: UIImage { get }
}

public extension ImageAsset {
  var image: UIImage {
    guard let image = UIImage(named: name, in: Bundle(for: ImageDummy.self), compatibleWith: .none) else {
      fatalError("Can't find the \(name) image asset.")
    }
    return image
  }
  
  var imageTemplate: UIImage {
    return image.withRenderingMode(.alwaysTemplate)
  }
  
  var imageOriginal: UIImage {
    return image.withRenderingMode(.alwaysOriginal)
  }
}

public extension ImageAsset where Self: RawRepresentable, Self.RawValue == String {
  var name: String {
    return rawValue
  }
}
