//
//  SwiftyNetworkingRouter.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

import Foundation

public protocol SwiftyNetworkingRouter {
    typealias Scheme = SwiftyNetworkingRequest.Scheme
    typealias Method = SwiftyNetworkingRequest.Method
    var scheme: Scheme { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var method: Method { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var cachePolicy: CachePolicy { get }
    var timeout: TimeInterval { get }
}
