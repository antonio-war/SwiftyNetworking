//
//  TestSwiftyNetworkingRouter.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

@testable import SwiftyNetworking
import Foundation

enum TestSwiftyNetworkingRouter: SwiftyNetworkingRouter {
    case users
    case user(id: Int)
    
    var endpoint: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .users:
            "/"
        case .user(let id):
            "/\(id)"
        }
    }
}
