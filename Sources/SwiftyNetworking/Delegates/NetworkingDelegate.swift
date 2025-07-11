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
        guard let request = metrics.transactionMetrics.first?.request else { return }
        self.cache.setObject(metrics, forKey: NSNumber(value: request.hashValue))
    }
    
    public func metric(for request: NetworkingRequest) -> NetworkingMetric? {
        guard let metrics = cache.object(forKey: NSNumber(value: request.rawValue.hashValue)) else { return nil }
        return NetworkingMetric(rawValue: metrics)
    }
        
    public static let `default`: NetworkingDelegate = {
        let cache: NSCache<NSNumber, URLSessionTaskMetrics> = NSCache()
        return NetworkingDelegate(cache: cache)
    }()
}
