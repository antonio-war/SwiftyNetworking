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
    
    init(resourceFetchType: URLSessionTaskMetrics.ResourceFetchType) {
        switch resourceFetchType {
        case .localCache:
            self = .cache
        default:
            self = .network
        }
    }
}
