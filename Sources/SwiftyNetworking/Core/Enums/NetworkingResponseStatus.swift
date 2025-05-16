//
//  NetworkingResponseStatus.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

public enum NetworkingResponseStatus: String, Sendable {
    case invalid = "INVALID"
    case information = "INFORMATION"
    case success = "SUCCESS"
    case redirection = "REDIRECTION"
    case clientError = "CLIENT_ERROR"
    case serverError = "SERVER_ERROR"
}
