//
//  NetworkingQueue.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

import Foundation

public final class NetworkingQueue: OperationQueue, @unchecked Sendable {
    
    public static let `default`: NetworkingQueue = {
        let queue = NetworkingQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .utility
        return queue
    }()
}
