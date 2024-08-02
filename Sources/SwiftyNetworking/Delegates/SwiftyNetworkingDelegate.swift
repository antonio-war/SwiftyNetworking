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
            return (.network, Date(), Date())
        }
        let source = SwiftyNetworkingSource(resourceFetchType: metrics.resourceFetchType)
        let start = metrics.requestStartDate ?? Date()
        let end = metrics.responseEndDate ?? Date()
        return (source, start, end)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.metrics[metrics.request.hashValue] = metrics
        }
    }
}
