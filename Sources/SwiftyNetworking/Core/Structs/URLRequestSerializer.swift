//
//  URLRequestSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation

public struct URLRequestSerializer: Sendable {
    
    public init() {}
    
    func serialize(_ request: NetworkingRequest) -> URLRequest {
        var urlRequest = URLRequest(url: url(request), cachePolicy: cachePolicy(request), timeoutInterval: timeoutInterval(request))
        urlRequest.httpMethod = httpMethod(request)
        urlRequest.httpBody = httpBody(request)
        urlRequest.allHTTPHeaderFields = allHTTPHeaderFields(request)
        return urlRequest
    }
    
    func url(_ request: NetworkingRequest) -> URL {
        guard var components = URLComponents(url: request.url, resolvingAgainstBaseURL: false) else { return request.url }
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { return request.url }
        return url
    }
    
    func cachePolicy(_ request: NetworkingRequest) -> URLRequest.CachePolicy {
        return request.cachePolicy.rawValue
    }

    func timeoutInterval(_ request: NetworkingRequest) -> TimeInterval {
        return request.timeout
    }
    
    func httpMethod(_ request: NetworkingRequest) -> String? {
        return request.method.rawValue
    }
    
    func httpBody(_ request: NetworkingRequest) -> Data? {
        return request.body
    }
    
    func allHTTPHeaderFields(_ request: NetworkingRequest) -> [String: String] {
        return request.headers
    }
}
