//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var metrics: [Int: URLSessionTaskTransactionMetrics]
    
    init(metrics: [Int : URLSessionTaskTransactionMetrics]) {
        self.metrics = metrics
    }
        
    func metrics(for request: URLRequest) -> SwiftyNetworkingMetrics {
        guard let metrics = metrics[request.hashValue] else {
            return (nil, nil, nil)
        }
        self.metrics[request.hashValue] = nil
        return (metrics.resourceFetchType, metrics.requestStartDate, metrics.responseEndDate)
    }
        
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.metrics[metrics.request.hashValue] = metrics
        }
    }
}
