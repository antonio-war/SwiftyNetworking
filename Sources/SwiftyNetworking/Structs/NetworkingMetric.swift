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
    public let source: NetworkingSource
    public let `protocol`: NetworkingProtocol?
    
    public init(
        start: Date,
        end: Date,
        duration: TimeInterval,
        redirections: Int,
        source: NetworkingSource,
        protocol: NetworkingProtocol?
    ) {
        self.start = start
        self.end = end
        self.duration = duration
        self.redirections = redirections
        self.source = source
        self.protocol = `protocol`
    }
    
    public init?(rawValue: URLSessionTaskMetrics) {
        guard let metric = deserializer.deserialize(rawValue) else { return nil }
        self.start = metric.start
        self.end = metric.end
        self.duration = metric.duration
        self.redirections = metric.redirections
        self.source = metric.source
        self.protocol = metric.protocol
    }
    
    private let deserializer: URLSessionTaskMetricsDeserializer = URLSessionTaskMetricsDeserializer()
}
