//
//  SwiftyNetworkingRouter.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

import Foundation

public protocol SwiftyNetworkingRouter {
    var endpoint: String { get }
    var path: String { get }
    var method: SwiftyNetworkingMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var parameters: [String: Any] { get }
    var cachePolicy: SwiftyNetworkingCachePolicy { get }
    var timeout: TimeInterval { get }
}
