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
        cachePolicy: NetworkingCachePolicy = .useProtocolCachePolicy,
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
        guard let builder = NetworkingRequestBuilder(rawValue) else { return nil }
        self.url = builder.url()
        self.method = builder.method()
        self.headers = builder.headers()
        self.queryParameters = builder.queryParameters()
        self.body = builder.body()
        self.cachePolicy = builder.cachePolicy()
        self.timeout = builder.timeout()
    }
    
    public var rawValue: URLRequest {
        let serializer = URLRequestSerializer(self)
        return serializer.serialize()
    }
}
