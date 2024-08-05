//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var cache: NSCache<NSNumber, URLSessionTaskTransactionMetrics>
    
    public init(cache: NSCache<NSNumber, URLSessionTaskTransactionMetrics> = NSCache(countLimit: 5)) {
        self.cache = cache
    }
        
    public func fetchType(for request: URLRequest) -> FetchType? {
        guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
            return nil
        }
        return metrics.resourceFetchType
    }
        
    public func start(for request: URLRequest) -> Date? {
        guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
            return nil
        }
        return metrics.requestStartDate
    }
    
    public func end(for request: URLRequest) -> Date? {
        guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
            return nil
        }
        return metrics.responseEndDate
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            cache.setObject(metrics, forKey: metrics.request.hashValue as NSNumber)
        }
    }
}
