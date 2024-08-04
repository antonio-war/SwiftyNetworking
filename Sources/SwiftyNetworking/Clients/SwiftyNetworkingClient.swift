//
//  SwiftyNetworkingClient.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingClient {
    private let delegate: SwiftyNetworkingDelegate = SwiftyNetworkingDelegate(metrics: [:])
    private let session: URLSession
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration, delegate: delegate)
    }
    
    public func send(_ request: SwiftyNetworkingRequest, completion: @escaping (Result<SwiftyNetworkingResponse, Error>) -> Void) {
        do {
            let underlyingRequest = try request.underlyingRequest
            
            let dataTask = session.dataTask(with: underlyingRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.cannotParseResponse)))
                    return
                }
                
                let metrics = self.delegate.metrics(for: underlyingRequest)
                let response = SwiftyNetworkingResponse(
                    body: data,
                    source: metrics.source,
                    start: metrics.start,
                    end: metrics.end,
                    underlyingResponse: httpResponse
                )
                completion(.success(response))
            }
            
            dataTask.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    public func send(_ request: SwiftyNetworkingRequest) async throws -> SwiftyNetworkingResponse {
        try await withCheckedThrowingContinuation { continuation in
            send(request) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func send(_ router: SwiftyNetworkingRouter, completion: @escaping (Result<SwiftyNetworkingResponse, Error>) -> Void) {
        send(router.rawValue, completion: completion)
    }
    
    public func send(_ router: SwiftyNetworkingRouter) async throws -> SwiftyNetworkingResponse {
        try await send(router.rawValue)
    }
}
