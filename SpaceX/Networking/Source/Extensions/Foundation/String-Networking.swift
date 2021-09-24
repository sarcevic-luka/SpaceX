//
//  String-Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

extension String: ParameterEncoding {
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var request = try urlRequest.asURLRequest()
    request.httpBody = data(using: .utf8, allowLossyConversion: false)
    return request
  }
}
