//
//  SwiftyNetworkingRouter+.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

import Foundation

public extension SwiftyNetworkingRouter {
    var method: SwiftyNetworkingMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var body: Data? {
        nil
    }
    
    var parameters: [String: Any] {
        [:]
    }
    
    var cachePolicy: SwiftyNetworkingCachePolicy {
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
            method: method,
            headers: headers,
            body: body,
            parameters: parameters,
            cachePolicy: cachePolicy,
            timeout: timeout
        )
    }
}
