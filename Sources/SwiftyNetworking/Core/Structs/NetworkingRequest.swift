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
        guard let request = deserializer.deserialize(rawValue) else { return nil }
        self.url = request.url
        self.method = request.method
        self.headers = request.headers
        self.queryParameters = request.queryParameters
        self.body = request.body
        self.cachePolicy = request.cachePolicy
        self.timeout = request.timeout
    }
    
    public var rawValue: URLRequest {
        return serializer.serialize(self)
    }
    
    private let serializer: URLRequestSerializer = URLRequestSerializer()
    private let deserializer: URLRequestDeserializer = URLRequestDeserializer()
}
