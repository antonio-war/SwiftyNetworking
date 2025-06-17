//
//  NetworkingCachePolicy.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 13/06/25.
//

import Foundation

@frozen
public enum NetworkingCachePolicy: String, Decodable, RawRepresentable {
    case returnCacheDataDontLoad = "RETURN_CACHE_DATA_DONT_LOAD"
    case returnCacheDataElseLoad = "RETURN_CACHE_DATA_ELSE_LOAD"
    case reloadIgnoringCacheData = "RELOAD_IGNORING_CACHE_DATA"
    case reloadRevalidatingCacheData = "RELOAD_REVALIDATING_CACHE_DATA"
    case useProtocolCachePolicy = "USE_PROTOCOL_CACHE_POLICY"
    
    public init?(rawValue: URLRequest.CachePolicy) {
        switch rawValue {
        case .reloadIgnoringCacheData: self = .reloadIgnoringCacheData
        case .returnCacheDataElseLoad: self = .returnCacheDataElseLoad
        case .returnCacheDataDontLoad: self = .returnCacheDataDontLoad
        case .reloadRevalidatingCacheData: self = .reloadRevalidatingCacheData
        case .useProtocolCachePolicy: self = .useProtocolCachePolicy
        default: return nil
        }
    }
    
    public var rawValue: URLRequest.CachePolicy {
        switch self {
        case .reloadIgnoringCacheData: .reloadIgnoringCacheData
        case .returnCacheDataElseLoad: .returnCacheDataElseLoad
        case .returnCacheDataDontLoad: .returnCacheDataDontLoad
        case .reloadRevalidatingCacheData: .reloadRevalidatingCacheData
        case .useProtocolCachePolicy: .useProtocolCachePolicy
        }
    }
}
