//
//  NetworkingRequest.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

import Foundation

public final class NetworkingRequest: Sendable {
    public let url: URL
    public let method: NetworkingMethod
    public let headers: [String: String]
    public let body: Data?
    public let cachePolicy: NetworkingCachePolicy
    public let timeout: TimeInterval
    
    public init(
        url: URL,
        method: NetworkingMethod = .get,
        headers: [String : String] = [:],
        body: Data? = nil,
        cachePolicy: NetworkingCachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
        
    public required init?(rawValue: URLRequest) {
        guard let url = rawValue.url else { return nil }
        guard let rawMethod = rawValue.httpMethod, let method = NetworkingMethod(rawValue: rawMethod) else { return nil }
        self.url = url
        self.method = method
        self.headers = rawValue.allHTTPHeaderFields ?? [:]
        self.body = rawValue.httpBody
        self.cachePolicy = rawValue.cachePolicy
        self.timeout = rawValue.timeoutInterval
    }
    
    var rawValue: URLRequest {
        get {
            var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
