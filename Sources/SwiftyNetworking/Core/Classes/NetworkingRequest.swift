//
//  NetworkingRequest.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

import Foundation

public struct NetworkingRequest: Sendable, RawRepresentable {
    public let url: URL
    public let method: NetworkingMethod
    public var headers: [String: String]
    public var queryParameters: [String: String]
    public var body: Data?
    public let cachePolicy: NetworkingCachePolicy
    public let timeout: TimeInterval
    
    public init(
        url: URL,
        method: NetworkingMethod = .get,
        headers: [String : String] = [:],
        queryParameters: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: NetworkingCachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) {
        self.url = NetworkingRequest.url(url: url)
        self.method = method
        self.headers = headers
        self.queryParameters = NetworkingRequest.queryParameters(url: url, queryParameters: queryParameters)
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
        
    public init?(rawValue: URLRequest) {
        guard let url = NetworkingRequest.url(rawValue: rawValue) else { return nil }
        guard let method = NetworkingRequest.method(rawValue: rawValue) else { return nil }
        guard let cachePolicy = NetworkingRequest.cachePolicy(rawValue: rawValue) else { return nil }
        self.url = url
        self.method = method
        self.headers = NetworkingRequest.headers(rawValue: rawValue)
        self.queryParameters = NetworkingRequest.queryParameters(rawValue: rawValue)
        self.body = NetworkingRequest.body(rawValue: rawValue)
        self.cachePolicy = cachePolicy
        self.timeout = NetworkingRequest.timeout(rawValue: rawValue)
    }
    
    public var rawValue: URLRequest {
        get {
            let url = NetworkingRequest.url(url: url, queryParameters: queryParameters)
            var request = URLRequest(url: url, cachePolicy: cachePolicy.rawValue, timeoutInterval: timeout)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
