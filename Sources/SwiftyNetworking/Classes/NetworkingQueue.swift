//
//  NetworkingQueue.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

import Foundation

public final class NetworkingQueue: OperationQueue, @unchecked Sendable {
    
    override init() {
        super.init()
        self.maxConcurrentOperationCount = 1
        self.qualityOfService = .utility
    }
    
    public static let `default`: NetworkingQueue = NetworkingQueue()
}
