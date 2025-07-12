//
//  NetworkingError.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

public enum NetworkingError: Error, Equatable {
    case invalidRequest
    case invalidResponse
    case unexpected(_ error: Error)
    
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.unexpected(let lhs), .unexpected(let rhs)):
            return lhs.localizedDescription == rhs.localizedDescription
        default:
            return false
        }
    }
}
