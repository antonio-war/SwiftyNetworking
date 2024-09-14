//
//  SwitfyNetworkingRequest+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation

extension SwiftyNetworkingRequest {
    
    typealias RawValue = URLRequest
    
    var rawValue: RawValue {
        get {
            var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
            request.httpMethod = method.rawValue.uppercased()
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
