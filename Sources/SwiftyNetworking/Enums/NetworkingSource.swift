//
//  NetworkingResponseSource.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

@frozen
public enum NetworkingSource: String, Sendable {
    case cache = "CACHE"
    case network = "NETWORK"
}
