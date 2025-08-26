//
//  NetworkingClient.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

public actor NetworkingClient: Sendable {
    private let session: URLSession
    private let delegate: NetworkingDelegate
    
    public init(configuration: URLSessionConfiguration = .default, delegate: NetworkingDelegate = .default, queue: NetworkingQueue = .default) {
        self.session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: queue)
        self.delegate = delegate
    }
    
    public func send(_ request: NetworkingRequest) async throws(NetworkingError) -> NetworkingResponse {
        do {
            guard request.scheme != nil else { throw NetworkingError.invalidRequest }
            let result = try await session.data(for: request.rawValue)
            guard var response = NetworkingResponse(rawValue: result) else { throw NetworkingError.invalidResponse }
            response.metric = delegate.metric(for: request)
            return response
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.unexpected(error)
        }
    }
    
    public static let shared: NetworkingClient = {
        return NetworkingClient(configuration: .default, delegate: .default, queue: .default)
    }()
}
