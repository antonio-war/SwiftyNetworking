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
    case posts(userId: Int)
    
    var host: String {
        "jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .users:
            "users/"
        case .user(let id):
            "users/\(id)/"
        case .posts:
            "posts/"
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .users:
            [:]
        case .user:
            [:]
        case .posts(let userId):
            ["userId": "\(userId)"]
        }
    }
    
    var cachePolicy: CachePolicy {
        .reloadIgnoringLocalCacheData
    }
}
