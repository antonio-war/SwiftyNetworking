//
//  SwiftyNetworkingRequest.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingRequest: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let endpoint: String
    public let path: String
    public let method: SwiftyNetworkingMethod
    public let headers: [String: String]
    public let body: Data?
    public let parameters: [String: String]
    public let cachePolicy: SwiftyNetworkingCachePolicy
    public let timeout: TimeInterval
    
    public init(
        id: UUID = UUID(),
        endpoint: String,
        path: String = "/",
        method: SwiftyNetworkingMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil,
        parameters: [String: Any] = [:],
        cachePolicy: SwiftyNetworkingCachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) {
        self.id = id
        self.endpoint = endpoint
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
        self.parameters = parameters.reduce(into: [String: String]()) { result, parameter in
            result[parameter.key] = String(describing: parameter.value)
        }
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    var url: URL {
        get throws {
            guard let endpoint = URL(string: endpoint) else {
                throw URLError(.badURL)
            }
            
            guard let scheme = endpoint.scheme, SwiftyNetworkingScheme(rawValue: scheme) != nil else {
                throw URLError(.badURL)
            }
            
            guard let url = URL(string: path, relativeTo: endpoint), var components = URLComponents(string: url.absoluteString) else {
                throw URLError(.badURL)
            }
            
            guard !parameters.isEmpty else {
                return url
            }
            
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
        }
    }
    
    var underlyingRequest: URLRequest {
        get throws {
            var request = try URLRequest(url: url, cachePolicy: cachePolicy.underlyingCachePolicy, timeoutInterval: timeout)
            request.httpMethod = method.rawValue.uppercased()
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
