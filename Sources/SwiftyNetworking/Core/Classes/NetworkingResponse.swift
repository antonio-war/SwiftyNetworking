//
//  NetworkingResponse.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

import Foundation

public final class NetworkingResponse: Sendable, RawRepresentable {
    public let url: URL
    public let code: Int
    public let headers: [String: String]
    public let body: Data
    public let rawValue: (data: Data, response: HTTPURLResponse)
    
    public required init?(rawValue: (data: Data, response: HTTPURLResponse)) {
        guard let url = rawValue.response.url else { return nil }
        self.url = url
        self.code = rawValue.response.statusCode
        self.headers = rawValue.response.allHeaderFields as? [String: String] ?? [:]
        self.body = rawValue.data
        self.rawValue = rawValue
    }
    
    public var status: NetworkingResponseStatus {
        return switch code {
        case 100 ... 199: .information
        case 200 ... 299: .success
        case 300 ... 399: .redirection
        case 400 ... 499: .clientError
        case 500 ... 599: .serverError
        default: .invalid
        }
    }
}
