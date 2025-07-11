//
//  NetworkingStandard.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

@frozen
public enum NetworkingStandard: String, Sendable {
    case http1 = "HTTP/1.1"
    case http2 = "H2"
    case http3 = "HTTP/3"
}
