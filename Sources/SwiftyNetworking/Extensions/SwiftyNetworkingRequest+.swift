//
//  SwitfyNetworkingRequest+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation

extension SwiftyNetworkingRequest {
    
    typealias RawValue = URLRequest
    
    public init(
        id: UUID = UUID(),
        url: URL,
        method: Method = .get,
        headers: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) throws {
        guard let components = URLComponents(string: url.absoluteString), let endpoint = components.host else {
            throw URLError(.badURL)
        }
        self.init(
            id: id,
            endpoint: endpoint,
            path: components.path,
            parameters: [:],
            method: method,
            headers: headers,
            body: body,
            cachePolicy: cachePolicy,
            timeout: timeout
        )
    }
    
    enum Scheme: String, Equatable, Hashable, Sendable {
        case http
        case https
    }
    
    var url: URL {
        get throws {
            guard let endpoint = URL(string: endpoint) else {
                throw URLError(.badURL)
            }
            
            guard let scheme = endpoint.scheme, Scheme(rawValue: scheme) != nil else {
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
    
    var rawValue: RawValue {
        get throws {
            var request = try URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
            request.httpMethod = method.rawValue.uppercased()
            request.httpBody = body
            request.allHTTPHeaderFields = headers
            return request
        }
    }
}
