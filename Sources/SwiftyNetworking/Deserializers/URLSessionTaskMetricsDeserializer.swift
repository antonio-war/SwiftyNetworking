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
            redirections: redirections(metrics)
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
}
