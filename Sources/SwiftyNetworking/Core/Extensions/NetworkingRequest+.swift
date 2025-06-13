//
//  NetworkingRequest+.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 13/06/25.
//

import Foundation

extension NetworkingRequest {
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
