//
//  SwiftyNetworkingResponse+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation

public extension SwiftyNetworkingResponse {
    
    enum Status: String, Equatable, Hashable, Sendable {
        case invalid
        case information
        case success
        case redirection
        case clientError
        case serverError
    }
    
    var status: Status {
        switch self.code {
        case 100 ... 199:
            return .information
        case 200 ... 299:
            return .success
        case 300 ... 399:
            return .redirection
        case 400 ... 499:
            return .clientError
        case 500 ... 599:
            return .serverError
        default:
            return .invalid
        }
    }
    
    var duration: TimeInterval? {
        guard let start, let end else {
            return nil
        }
        return end.timeIntervalSince(start)
    }
}
