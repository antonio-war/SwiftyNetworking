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
    
    static func url(rawValue: URLRequest) -> URL? {
        guard let url = rawValue.url else { return nil }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        components.queryItems = nil
        guard let url = components.url else { return url }
        return url
    }
    
    static func url(url: URL) -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        components.queryItems = nil
        guard let url = components.url else { return url }
        return url
    }
    
    static func url(url: URL, queryParameters: [String: String]) -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { return url }
        return url
    }
    
    static func method(rawValue: URLRequest) -> NetworkingMethod? {
        guard let rawMethod = rawValue.httpMethod else { return nil }
        guard let method = NetworkingMethod(rawValue: rawMethod) else { return nil }
        return method
    }
    
    static func headers(rawValue: URLRequest) -> [String: String] {
        guard let headers = rawValue.allHTTPHeaderFields else { return [:] }
        return headers
    }
    
    static func queryParameters(rawValue: URLRequest) -> [String: String] {
        guard let url = rawValue.url else { return [:] }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return [:] }
        guard let queryParameters = components.queryItems else { return [:] }
        return Dictionary(uniqueKeysWithValues:
            queryParameters.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
    }
    
    static func queryParameters(url: URL, queryParameters: [String: String]) -> [String: String] {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return queryParameters }
        guard let urlParameters = components.queryItems else { return queryParameters }
        return Dictionary(uniqueKeysWithValues:
            urlParameters.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        ).merging(queryParameters, uniquingKeysWith: { _, new in new })
    }
    
    static func body(rawValue: URLRequest) -> Data? {
        return rawValue.httpBody
    }
    
    static func cachePolicy(rawValue: URLRequest) -> NetworkingCachePolicy? {
        guard let cachePolicy = NetworkingCachePolicy(rawValue: rawValue.cachePolicy) else { return nil }
        return cachePolicy
    }
        
    static func timeout(rawValue: URLRequest) -> TimeInterval {
        return rawValue.timeoutInterval
    }
}
