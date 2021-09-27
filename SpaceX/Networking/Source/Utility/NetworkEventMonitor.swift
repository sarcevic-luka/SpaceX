//
//  NetworkEventMonitor.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

internal struct NetworkEventMonitor {
  internal let logsResponses: Bool
  internal let logsHeaders: Bool
  internal init(logsHeaders: Bool = true, logsResponses: Bool = true) {
    self.logsHeaders = logsHeaders
    self.logsResponses = logsResponses
  }
}

extension NetworkEventMonitor: EventMonitor {
  internal func request(_ request: Alamofire.Request, didCreateURLRequest urlRequest: URLRequest) {
    guard let url = urlRequest.url, let method = urlRequest.method else { return }
    var log = [method.rawValue, url.absoluteString].joined(separator: " ")
    if let headers = request.request?.headers, logsHeaders {
      log += "\nHeaders:\n \(headers.description)"
    }
    if [HTTPMethod.post, HTTPMethod.put, HTTPMethod.patch].contains(method), let body = urlRequest.httpBody, let json = String(data: body, encoding: .utf8) {
      log += "\nBody: \(json)"
    }
    debugPrint("🌐 | \(#function) | \(log)")
  }
  
  internal func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard
      logsResponses,
      let data = response.data,
      let object = try? JSONSerialization.jsonObject(with: data, options: []),
      let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let jsonString = String(data: prettyPrintedData, encoding: .utf8) else {
      return
    }
//    debugPrint("🌐 | \(#function)\nResponse: \(jsonString)")
  }
  
  internal func requestDidFinish(_ request: Alamofire.Request) {
    guard
      let urlRequest = request.request,
      let method = urlRequest.method,
      let response = request.response,
      let url = request.response?.url else { return }
    let log = [response.statusCode.description, method.rawValue, url.absoluteString].joined(separator: " ")
    debugPrint("🌐 | \(#function) | \(log)")
  }
}
