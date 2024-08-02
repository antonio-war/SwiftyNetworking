//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var metrics: [Int: URLSessionTaskTransactionMetrics] = [:]
    
    func metrics(for request: URLRequest) -> SwiftyNetworkingMetrics {
        guard let metrics = metrics[request.hashValue] else {
            return (.network, 0)
        }
        let source = SwiftyNetworkingSource(resourceFetchType: metrics.resourceFetchType)
        let duration = metrics.responseEndDate?.timeIntervalSince(metrics.requestStartDate ?? Date()) ?? 0.0
        return (source, duration)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.metrics[metrics.request.hashValue] = metrics
        }
    }
}
