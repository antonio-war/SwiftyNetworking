//
//  NetworkingMethod.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

public enum NetworkingMethod: String, Sendable {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}
