//
//  SwiftyNetworkingClient.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingClient {
    private let session: URLSession
    private let delegate: SwiftyNetworkingDelegate
    
    public init(
        configuration: URLSessionConfiguration = URLSessionConfiguration.default,
        delegate: SwiftyNetworkingDelegate = SwiftyNetworkingDelegate()
    ) {
        self.session = URLSession(
            configuration: configuration,
            delegate: delegate
        )
        self.delegate = delegate
    }
    
    public func send(_ request: SwiftyNetworkingRequest, completion: @escaping (Result<SwiftyNetworkingResponse, Error>) -> Void) {
        do {
            let rawRequest = try request.rawValue
            
            let dataTask = session.dataTask(with: rawRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let body = data, let rawResponse = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.cannotParseResponse)))
                    return
                }
                
                let response = SwiftyNetworkingResponse(
                    rawValue: rawResponse,
                    body: body,
                    fetchType: delegate.fetchType(for: rawRequest),
                    start: delegate.start(for: rawRequest),
                    end: delegate.end(for: rawRequest)
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
