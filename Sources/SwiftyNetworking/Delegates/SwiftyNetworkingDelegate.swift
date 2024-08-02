//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var metrics: [Int: URLSessionTaskTransactionMetrics] = [:]
    
    func source(for request: URLRequest) -> SwiftyNetworkingSource {
        guard let metrics = metrics[request.hashValue] else {
            return .unknown
        }
        self.metrics[request.hashValue] = nil
        return SwiftyNetworkingSource(resourceFetchType: metrics.resourceFetchType)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.metrics[metrics.request.hashValue] = metrics
        }
    }
}
