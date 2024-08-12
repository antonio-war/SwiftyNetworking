//
//  JsonPlaceholderRouter.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

@testable import SwiftyNetworking
import Foundation

enum JsonPlaceholderRouter: SwiftyNetworkingRouter {
    case users
    case user(id: Int)
    
    var endpoint: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .users:
            "users/"
        case .user(let id):
            "users/\(id)"
        }
    }
    
    var cachePolicy: CachePolicy {
        .reloadIgnoringLocalCacheData
    }
}
