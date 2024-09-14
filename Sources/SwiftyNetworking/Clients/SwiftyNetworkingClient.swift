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
        self.session = URLSession(configuration: configuration, delegate: delegate)
        self.delegate = delegate
    }
    
    public func send(_ request: SwiftyNetworkingRequest, completion: @escaping (Result<SwiftyNetworkingResponse, Error>) -> Void) {
        let dataTask = session.dataTask(with: request.rawValue) { data, response, error in
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
                fetchType: delegate.fetchType(for: request.rawValue),
                start: delegate.start(for: request.rawValue),
                end: delegate.end(for: request.rawValue)
            )
            completion(.success(response))
        }
        dataTask.resume()
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
    
    public func send<Model: Decodable>(_ request: SwiftyNetworkingRequest, decoding model: Model.Type, using decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<Model, Error>) -> Void) {
        send(request) { result in
            do {
                switch result {
                case .success(let response):
                    guard response.status == .success else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }
                    let model = try decoder.decode(model, from: response.body)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func send<Model: Decodable>(_ request: SwiftyNetworkingRequest, decoding model: Model.Type, using decoder: JSONDecoder = JSONDecoder()) async throws -> Model {
        try await withCheckedThrowingContinuation { continuation in
            send(request, decoding: model, using: decoder) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
