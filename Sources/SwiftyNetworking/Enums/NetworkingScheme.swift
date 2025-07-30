//
//  NetworkingScheme.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 12/07/25.
//

@frozen
public enum NetworkingScheme: String, Sendable {
    case http = "HTTP"
    case https = "HTTPS"
    
    public var secure: Bool {
        switch self {
        case .http: return false
        case .https: return true
        }
    }
}
