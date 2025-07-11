//
//  NetworkingDelegate.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 02/07/25.
//

import Foundation

final class NetworkingDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metric in metrics.transactionMetrics {
            print(metric.resourceFetchType)
        }
    }
}
