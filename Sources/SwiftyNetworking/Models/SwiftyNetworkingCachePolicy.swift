//
//  SwiftyNetworkingCachePolicy.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

import Foundation

public enum SwiftyNetworkingCachePolicy: String, Equatable, Hashable, Sendable {
    case reloadIgnoringCacheData
    case returnCacheDataElseLoad
    case returnCacheDataDontLoad
    
    var underlyingCachePolicy: NSURLRequest.CachePolicy {
        switch self {
        case .reloadIgnoringCacheData:
            return .reloadIgnoringLocalCacheData
        case .returnCacheDataElseLoad:
            return .returnCacheDataElseLoad
        case .returnCacheDataDontLoad:
            return .returnCacheDataDontLoad
        }
    }
}
