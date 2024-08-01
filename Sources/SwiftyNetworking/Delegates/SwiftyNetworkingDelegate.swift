//
//  SwiftyNetworkingDelegate.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

class SwiftyNetworkingDelegate: NSObject, URLSessionTaskDelegate {
    private var sources: [URLRequest: SwiftyNetworkingSource] = [:]
    
    func source(for request: URLRequest) -> SwiftyNetworkingSource {
        guard let source = sources[request] else {
            return .unknown
        }
        sources[request] = nil
        return source
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metrics in metrics.transactionMetrics {
            self.sources[metrics.request] = SwiftyNetworkingSource(resourceFetchType: metrics.resourceFetchType)
        }
    }
}
