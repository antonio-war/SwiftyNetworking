//
//  NetworkingRequestSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation

struct NetworkingRequestSerializer: Sendable {
    private let defaultUrl: URL
    private let defaultMethod: NetworkingMethod
    private let defaultHeaders: [String: String]
    private let defaultQueryParameters: [String: String]
    private let defaultBody: Data?
    private let defaultCachePolicy: NetworkingCachePolicy
    private let defaultTimeout: TimeInterval
    
    init(_ request: NetworkingRequest) {
        self.defaultUrl = request.url
        self.defaultMethod = request.method
        self.defaultHeaders = request.headers
        self.defaultQueryParameters = request.queryParameters
        self.defaultBody = request.body
        self.defaultCachePolicy = request.cachePolicy
        self.defaultTimeout = request.timeout
    }
    
    func url() -> URL {
        guard var components = URLComponents(url: defaultUrl, resolvingAgainstBaseURL: false) else { return defaultUrl }
        components.queryItems = defaultQueryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { return defaultUrl }
        return url
    }
    
    func httpMethod() -> String {
        return defaultMethod.rawValue
    }
        
    func allHTTPHeaderFields() -> [String: String] {
        return defaultHeaders
    }
    
    func httpBody() -> Data? {
        return defaultBody
    }
    
    func cachePolicy() -> URLRequest.CachePolicy {
        return defaultCachePolicy.rawValue
    }
    
    func timeoutInterval() -> TimeInterval {
        return defaultTimeout
    }
}
