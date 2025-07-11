//
//  NetworkingDelegate.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 02/07/25.
//

import Foundation

public final class NetworkingDelegate: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    private let cache: NSCache<NSNumber, URLSessionTaskMetrics>
    
    public init(cache: NSCache<NSNumber, URLSessionTaskMetrics> = NSCache()) {
        self.cache = cache
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        self.cache.setObject(metrics, forKey: task.taskIdentifier as NSNumber)
    }
    
    public func metric(for identifier: Int) -> NetworkingMetric {
        return NetworkingMetric(start: .init(), end: .init(), redirections: 1)
    }
    
    public static let `default`: NetworkingDelegate = {
        let cache: NSCache<NSNumber, URLSessionTaskMetrics> = NSCache()
        return NetworkingDelegate(cache: cache)
    }()
}
