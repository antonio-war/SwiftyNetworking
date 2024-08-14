//
//  SwiftyNetworkingRequest.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingRequest: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let endpoint: String
    public let path: String
    public let method: Method
    public let parameters: [String: String]
    public let headers: [String: String]
    public let body: Data?
    public let cachePolicy: CachePolicy
    public let timeout: TimeInterval
        
    public init(
        id: UUID = UUID(),
        endpoint: String,
        path: String = "/",
        parameters: [String: String] = [:],
        method: Method = .get,
        headers: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) {
        self.id = id
        self.endpoint = endpoint
        self.path = path.first == "/" ? path : "/" + path
        self.parameters = parameters
        self.method = method
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    public enum Method: String, Equatable, Hashable, Sendable {
        case connect
        case delete
        case get
        case head
        case options
        case patch
        case post
        case put
        case trace
    }
}
