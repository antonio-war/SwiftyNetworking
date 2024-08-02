//
//  SwiftyNetworkingResponse.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingResponse: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let body: Data
    public let status: Int
    public let headers: [String: String]
    public let source: SwiftyNetworkingSource
    public let duration: TimeInterval
    
    init(id: UUID = UUID(), body: Data, source: SwiftyNetworkingSource, duration: TimeInterval, underlyingResponse: HTTPURLResponse) {
        self.id = id
        self.body = body
        self.status = underlyingResponse.statusCode
        self.headers = underlyingResponse.allHeaderFields.reduce(into: [String: String]()) { result, header in
            if let name = header.key as? String, let value = header.value as? String {
                result[name] = value
            }
        }
        self.source = source
        self.duration = duration
        self.underlyingResponse = underlyingResponse
    }
    
    var underlyingResponse: HTTPURLResponse
}
