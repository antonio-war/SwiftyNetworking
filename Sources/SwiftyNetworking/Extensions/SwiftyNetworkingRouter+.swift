//
//  SwiftyNetworkingRouter+.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

import Foundation

public extension SwiftyNetworkingRouter {

    var scheme: Scheme {
        .https
    }
    
    var path: String {
        "/"
    }
    
    var parameters: [String: String] {
        [:]
    }
    
    var method: Method {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var body: Data? {
        nil
    }
    
    var cachePolicy: CachePolicy {
        .returnCacheDataElseLoad
    }
    
    var timeout: TimeInterval {
        60
    }
    
    var request: SwiftyNetworkingRequest {
        get throws {
            try SwiftyNetworkingRequest(
                scheme: scheme,
                host: host,
                path: path,
                parameters: parameters, method: method,
                headers: headers,
                body: body,
                cachePolicy: cachePolicy,
                timeout: timeout
            )
        }
    }
}
