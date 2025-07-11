//
//  NetworkingMetric.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

import Foundation

public struct NetworkingMetric: Sendable {
    public let start: Date
    public let end: Date
    public let redirections: Int
}
