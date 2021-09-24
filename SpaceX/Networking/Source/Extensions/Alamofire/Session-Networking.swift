//
//  Session-Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 24.09.2021..
//

import Foundation
import Alamofire

extension Session {
  func request(resource: Resource,
               parameters: Parameters? = nil,
               encoding: ParameterEncoding = URLEncoding.default,
               interceptor: RequestInterceptor? = nil,
               requestModifier: RequestModifier? = nil) -> DataRequest {
    request(resource.url,
            method: resource.method,
            parameters: parameters,
            encoding: encoding,
            headers: nil,
            interceptor: interceptor,
            requestModifier: requestModifier)
  }
  
  func request<Parameters: Encodable>(resource: Resource,
                                      parameters: Parameters? = nil,
                                      encoder: ParameterEncoder = JSONParameterEncoder(encoder: JSONEncoder.default),
                                      interceptor: RequestInterceptor? = nil,
                                      requestModifier: RequestModifier? = nil) -> DataRequest {
    request(resource.url,
            method: resource.method,
            parameters: parameters,
            encoder: encoder,
            headers: nil,
            interceptor: interceptor,
            requestModifier: requestModifier)
  }
}
