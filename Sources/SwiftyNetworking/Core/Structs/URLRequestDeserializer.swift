//
//  URLRequestDeserializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation

struct URLRequestDeserializer: Sendable {
    
    func deserialize(_ request: URLRequest) -> NetworkingRequest? {
        guard let url = url(request) else { return nil }
        guard let method = method(request) else { return nil }
        guard let queryParameters = queryParameters(request) else { return nil }
        guard let cachePolicy = cachePolicy(request) else { return nil }
        return NetworkingRequest(
            url: url,
            method: method,
            headers: headers(request),
            queryParameters: queryParameters,
            body: body(request),
            cachePolicy: cachePolicy,
            timeout: timeout(request)
        )
    }
    
    func url(_ request: URLRequest) -> URL? {
        guard let url = request.url else { return nil }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = nil
        guard let url = components.url else { return url }
        return url
    }
    
    func method(_ request: URLRequest) -> NetworkingMethod? {
        guard let httpMethod = request.httpMethod else { return nil }
        guard let method = NetworkingMethod(rawValue: httpMethod) else { return nil }
        return method
    }
    
    func headers(_ request: URLRequest) -> [String: String] {
        guard let headers = request.allHTTPHeaderFields else { return [:] }
        return headers
    }
    
    func queryParameters(_ request: URLRequest) -> [String: String]? {
        guard let url = request.url else { return nil }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        guard let queryParameters = components.queryItems, !queryParameters.isEmpty else { return [:] }
        return Dictionary(uniqueKeysWithValues:
            queryParameters.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
    }
    
    func body(_ request: URLRequest) -> Data? {
        return request.httpBody
    }
    
    func cachePolicy(_ request: URLRequest) -> NetworkingCachePolicy? {
        guard let cachePolicy = NetworkingCachePolicy(rawValue: request.cachePolicy) else { return nil }
        return cachePolicy
    }
    
    func timeout(_ request: URLRequest) -> TimeInterval {
        return request.timeoutInterval
    }
}
