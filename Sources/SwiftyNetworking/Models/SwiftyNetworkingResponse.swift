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
    public let start: Date
    public let end: Date
    
    init(id: UUID, body: Data, source: SwiftyNetworkingSource, start: Date, end: Date, underlyingResponse: HTTPURLResponse) {
        self.id = id
        self.body = body
        self.status = underlyingResponse.statusCode
        self.headers = underlyingResponse.allHeaderFields.reduce(into: [String: String]()) { result, header in
            if let name = header.key as? String, let value = header.value as? String {
                result[name] = value
            }
        }
        self.source = source
        self.start = start
        self.end = end
        self.underlyingResponse = underlyingResponse
    }
    
    public var duration: TimeInterval {
        end.timeIntervalSince(start)
    }
    
    var underlyingResponse: HTTPURLResponse
}
