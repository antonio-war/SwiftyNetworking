//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    private let cache: NSCache<NSNumber, URLSessionTaskTransactionMetrics>
    private let queue = DispatchQueue(label: "it.antoniowar.SwiftyNetworking.cache", attributes: .concurrent)

    public init(cache: NSCache<NSNumber, URLSessionTaskTransactionMetrics> = NSCache(countLimit: 5)) {
        self.cache = cache
    }

    public func fetchType(for request: URLRequest) -> FetchType? {
        return queue.sync {
            guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
                return nil
            }
            return metrics.resourceFetchType
        }
    }

    public func start(for request: URLRequest) -> Date? {
        return queue.sync {
            guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
                return nil
            }
            return metrics.requestStartDate
        }
    }

    public func end(for request: URLRequest) -> Date? {
        return queue.sync {
            guard let metrics = cache.object(forKey: request.hashValue as NSNumber) else {
                return nil
            }
            return metrics.responseEndDate
        }
    }

    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didFinishCollecting metrics: URLSessionTaskMetrics
    ) {
        queue.async(flags: .barrier) {
            for metric in metrics.transactionMetrics {
                self.cache.setObject(metric, forKey: metric.request.hashValue as NSNumber)
            }
        }
    }
}
