//
//  URLSessionTaskMetricsDeserializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

import Foundation

struct URLSessionTaskMetricsDeserializer: Sendable {
    
    func deserialize(_ metrics: URLSessionTaskMetrics) -> NetworkingMetric? {
        return NetworkingMetric(
            start: start(metrics),
            end: end(metrics),
            duration: duration(metrics),
            redirections: redirections(metrics),
            source: source(metrics),
            protocol: `protocol`(metrics)
        )
    }
    
    func start(_ metrics: URLSessionTaskMetrics) -> Date {
        metrics.taskInterval.start
    }
    
    func end(_ metrics: URLSessionTaskMetrics) -> Date {
        metrics.taskInterval.end
    }
    
    func duration(_ metrics: URLSessionTaskMetrics) -> TimeInterval {
        metrics.taskInterval.duration
    }
    
    func redirections(_ metrics: URLSessionTaskMetrics) -> Int {
        metrics.redirectCount
    }
    
    func source(_ metrics: URLSessionTaskMetrics) -> NetworkingSource {
        metrics.transactionMetrics.contains(where: { $0.resourceFetchType == .localCache }) ? .cache : .network
    }
    
    func `protocol`(_ metrics: URLSessionTaskMetrics) -> NetworkingProtocol? {
        guard let rawValue = metrics.transactionMetrics.last?.networkProtocolName?.uppercased() else { return nil }
        return NetworkingProtocol(rawValue: rawValue)
    }
}
