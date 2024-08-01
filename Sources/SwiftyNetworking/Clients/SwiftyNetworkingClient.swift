//
//  SwiftyNetworkingClient.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public actor SwiftyNetworkingClient {
    private let delegate: SwiftyNetworkingDelegate = SwiftyNetworkingDelegate()
    private let configuration: URLSessionConfiguration
    private let session: URLSession
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration, delegate: delegate)
    }
        
    public func send(request: SwiftyNetworkingRequest) async throws -> SwiftyNetworkingResponse {
        let underlyingRequest = try request.underlyingRequest
        let (body, underlyingResponse) = try await session.data(for: underlyingRequest)
        let source = delegate.source(for: underlyingRequest)
        guard let underlyingResponse = underlyingResponse as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        return SwiftyNetworkingResponse(source: source, body: body, underlyingResponse: underlyingResponse)
    }
}
