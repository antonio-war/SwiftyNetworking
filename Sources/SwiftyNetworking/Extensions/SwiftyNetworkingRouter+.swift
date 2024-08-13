//
//  SwiftyNetworkingRouter+.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

import Foundation

public extension SwiftyNetworkingRouter {
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
}

extension SwiftyNetworkingRouter {
    typealias RawValue = SwiftyNetworkingRequest
    
    var rawValue: RawValue {
        SwiftyNetworkingRequest(
            endpoint: endpoint,
            path: path,
            parameters: parameters, method: method,
            headers: headers,
            body: body,
            cachePolicy: cachePolicy,
            timeout: timeout
        )
    }
}
