//
//  NetworkingRequestBuilder.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation

struct NetworkingRequestBuilder: Sendable {
    private let defaultUrl: URL
    private let defaultComponents: URLComponents
    private let defaultMethod: String?
    private let defaultHeaders: [String: String]?
    private let defaultBody: Data?
    private let defaultCachePolicy: URLRequest.CachePolicy
    private let defaultTimeout: TimeInterval
    
    init?(_ rawValue: URLRequest) {
        guard let url = rawValue.url else { return nil }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        self.defaultUrl = url
        self.defaultComponents = components
        self.defaultMethod = rawValue.httpMethod
        self.defaultHeaders = rawValue.allHTTPHeaderFields
        self.defaultBody = rawValue.httpBody
        self.defaultCachePolicy = rawValue.cachePolicy
        self.defaultTimeout = rawValue.timeoutInterval
    }
    
    func url() -> URL {
        var components = defaultComponents
        components.queryItems = nil
        guard let url = components.url else { return defaultUrl }
        return url
    }
    
    func method() -> NetworkingMethod {
        guard let defaultMethod else { return .get }
        guard let method = NetworkingMethod(rawValue: defaultMethod) else { return .get }
        return method
    }
    
    func headers() -> [String: String] {
        guard let headers = defaultHeaders else { return [:] }
        return headers
    }
    
    func queryParameters() -> [String: String] {
        guard let defaultQueryParameters = defaultComponents.queryItems else { return [:] }
        return Dictionary(uniqueKeysWithValues:
            defaultQueryParameters.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
    }
    
    func body() -> Data? {
        return defaultBody
    }
    
    func cachePolicy() -> NetworkingCachePolicy {
        guard let cachePolicy = NetworkingCachePolicy(rawValue: defaultCachePolicy) else {
            return .useProtocolCachePolicy
        }
        return cachePolicy
    }
    
    func timeout() -> TimeInterval {
        return defaultTimeout
    }
}
