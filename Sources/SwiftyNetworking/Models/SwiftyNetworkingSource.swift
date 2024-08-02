//
//  SwiftyNetworkingSource.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

import Foundation

public enum SwiftyNetworkingSource: String, Equatable, Hashable, Sendable {
    case network
    case cache
    case unknown
    
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
