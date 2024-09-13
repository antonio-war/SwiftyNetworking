//
//  SwiftyNetworkingRequest.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingRequest: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let url: URL
    public let scheme: Scheme
    public let host: String
    public let path: String
    public let parameters: [String: String]
    public let method: Method
    public let headers: [String: String]
    public let body: Data?
    public let cachePolicy: CachePolicy
    public let timeout: TimeInterval
        
    public init(
        id: UUID = UUID(),
        url: URL,
        method: Method = .get,
        headers: [String : String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) throws {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        guard let rawScheme = components.scheme, let scheme = Scheme(rawValue: rawScheme) else {
            throw URLError(.unsupportedURL)
        }
        
        guard let host = components.host else {
            throw URLError(.badURL)
        }
        
        self.id = id
        self.url = url
        self.scheme = scheme
        self.host = host
        self.path = components.path
        self.parameters = components.queryItems?.reduce(into: [String: String]()) { result, item in
            if let value = item.value {
                result[item.name] = value
            }
        } ?? [:]
        self.method = method
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    public init(
        id: UUID = UUID(),
        scheme: Scheme = .https,
        host: String,
        path: String = "/",
        parameters: [String: String] = [:],
        method: Method = .get,
        headers: [String : String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60
    ) throws {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path.first == "/" ? path : "/" + path
        components.queryItems = parameters.isEmpty ? nil : parameters.reduce(into: [URLQueryItem]()) { result, item in
            result.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        self.id = id
        self.url = url
        self.scheme = scheme
        self.host = host
        self.path = path
        self.parameters = parameters
        self.method = method
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    public enum Scheme: String, Equatable, Hashable, Sendable {
        case http
        case https
    }
    
    public enum Method: String, Equatable, Hashable, Sendable {
        case connect
        case delete
        case get
        case head
        case options
        case patch
        case post
        case put
        case trace
    }
}
