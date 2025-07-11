//
//  NetworkingClient.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

public actor NetworkingClient: Sendable {
    private let session: URLSession
    
    public init(configuration: URLSessionConfiguration = .default, delegate: NetworkingDelegate = .default, queue: NetworkingQueue = .default) {
        self.session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: queue)
    }
    
    func send(_ request: NetworkingRequest) async throws(NetworkingError) -> NetworkingResponse {
        do {
            let result = try await session.data(for: request.rawValue)
            guard let response = NetworkingResponse(rawValue: result) else { throw NetworkingError.invalidResponse }
            return response
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.unexpected(error)
        }
    }
}
