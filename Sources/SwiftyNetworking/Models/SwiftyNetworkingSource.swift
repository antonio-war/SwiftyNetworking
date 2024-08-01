//
//  SwiftyNetworkingSource.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public enum SwiftyNetworkingSource: String, Equatable, Hashable, Sendable {
    case cache = "CACHE"
    case network = "NETWORK"
    case unknown = "UNKNOWN"
    
    init(resourceFetchType: URLSessionTaskMetrics.ResourceFetchType) {
        switch resourceFetchType {
        case .networkLoad:
            self = .network
        case .localCache:
            self = .cache
        default:
            self = .unknown
        }
    }
}
