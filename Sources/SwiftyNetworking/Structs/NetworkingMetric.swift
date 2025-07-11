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
    public let duration: TimeInterval
    public let redirections: Int
    
    public init(
        start: Date,
        end: Date,
        duration: TimeInterval,
        redirections: Int
    ) {
        self.start = start
        self.end = end
        self.duration = duration
        self.redirections = redirections
    }
    
    public init?(rawValue: URLSessionTaskMetrics) {
        guard let metric = deserializer.deserialize(rawValue) else { return nil }
        self.start = metric.start
        self.end = metric.end
        self.duration = metric.duration
        self.redirections = metric.redirections
    }
    
    private let deserializer: URLSessionTaskMetricsDeserializer = URLSessionTaskMetricsDeserializer()
}
