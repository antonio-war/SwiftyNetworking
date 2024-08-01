//
//  SwiftyNetworkingMethod.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public enum SwiftyNetworkingMethod: String, Equatable, Hashable, Sendable {
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
