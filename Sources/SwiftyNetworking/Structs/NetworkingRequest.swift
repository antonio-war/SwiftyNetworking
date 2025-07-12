//
//  NetworkingRequest.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

import Foundation

public struct NetworkingRequest: Sendable, RawRepresentable {
    public private(set) var url: URL
    public var method: NetworkingMethod
    public var headers: [String: String]
    public var queryParameters: [String: String]
    public var body: Data?
    public var cachePolicy: NetworkingCachePolicy
    public var timeout: TimeInterval
    
    public init(
        url: URL,
        method: NetworkingMethod = .get,
        headers: [String : String] = [:],
        queryParameters: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: NetworkingCachePolicy = .respectProtocolStandard,
        timeout: TimeInterval = 60
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        guard let queryItems = components.queryItems, !queryItems.isEmpty else { return }
        let extractedQueryParameters = Dictionary<String, String>(uniqueKeysWithValues:
            queryItems.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
        self.queryParameters.merge(extractedQueryParameters) { _, new in new }
        components.queryItems = nil
        guard let cleanedUrl = components.url else { return }
        self.url = cleanedUrl
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
    
    public var scheme: NetworkingScheme? {
        guard let rawValue = url.scheme?.uppercased() else { return nil }
        return NetworkingScheme(rawValue: rawValue)
    }
    
    private let serializer: URLRequestSerializer = URLRequestSerializer()
    private let deserializer: URLRequestDeserializer = URLRequestDeserializer()
}
