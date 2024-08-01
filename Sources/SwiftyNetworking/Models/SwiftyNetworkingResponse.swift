//
//  SwiftyNetworkingResponse.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingResponse: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let source: SwiftyNetworkingSource
    public let status: Int
    public let headers: [String: String]
    public let body: Data
    
    init(id: UUID = UUID(), source: SwiftyNetworkingSource, body: Data, underlyingResponse: HTTPURLResponse) {
        self.id = id
        self.source = source
        self.status = underlyingResponse.statusCode
        self.headers = underlyingResponse.allHeaderFields.reduce(into: [String: String]()) { result, header in
            if let name = header.key as? String, let value = header.value as? String {
                result[name] = value
            }
        }
        self.body = body
        self.underlyingResponse = underlyingResponse
    }
    
    var underlyingResponse: HTTPURLResponse
}
