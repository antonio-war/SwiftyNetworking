//
//  URLRequestSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation

struct URLRequestSerializer: Sendable {
    private let request: NetworkingRequest
    
    init(_ request: NetworkingRequest) {
        self.request = request
    }
    
    func serialize() -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
    
    private var url: URL {
        guard var components = URLComponents(url: request.url, resolvingAgainstBaseURL: false) else { return request.url }
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { return request.url }
        return url
    }
    
    private var cachePolicy: URLRequest.CachePolicy {
        return request.cachePolicy.rawValue
    }
    
    private var timeoutInterval: TimeInterval {
        return request.timeout
    }
    
    private var httpMethod: String? {
        return request.method.rawValue
    }
    
    private var httpBody: Data? {
        return request.body
    }
    
    private var allHTTPHeaderFields: [String: String] {
        return request.headers
    }
}
