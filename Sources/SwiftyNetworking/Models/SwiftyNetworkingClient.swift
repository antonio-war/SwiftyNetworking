//
//  SwiftyNetworkingClient.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public class SwiftyNetworkingClient {
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func send(request: SwiftyNetworkingRequest) async throws -> SwiftyNetworkingResponse {
        let (body, underlyingResponse) = try await session.data(for: request.underlyingRequest)
        guard let underlyingResponse = underlyingResponse as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        return SwiftyNetworkingResponse(body: body, underlyingResponse: underlyingResponse)
    }
}
