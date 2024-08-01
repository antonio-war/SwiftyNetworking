//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var sources: [URLRequest: URLSessionTaskTransactionMetrics] = [:]
    
    func metrics(for request: URLRequest) -> URLSessionTaskTransactionMetrics? {
        guard let source = sources[request] else {
            return nil
        }
        sources[request] = nil
        return source
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.sources[metrics.request] = metrics
        }
    }
}
