//
//  SwiftyNetworkingClient.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public actor SwiftyNetworkingClient {
    private let delegate: SwiftyNetworkingDelegate = SwiftyNetworkingDelegate(fileManager: .default)
    private let session: URLSession
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration, delegate: delegate)
    }
    
    public func send(request: SwiftyNetworkingRequest) async throws -> SwiftyNetworkingResponse {
        let underlyingRequest = try request.underlyingRequest
        let (body, underlyingResponse) = try await session.data(for: underlyingRequest)
        let metrics = delegate.metrics(for: underlyingRequest)
        guard let underlyingResponse = underlyingResponse as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        let response = SwiftyNetworkingResponse(
            id: request.id,
            body: body,
            source: metrics.source,
            start: metrics.start,
            end: metrics.end,
            underlyingResponse: underlyingResponse
        )
        delegate.dump(request: request, response: response)
        return response
    }
}
