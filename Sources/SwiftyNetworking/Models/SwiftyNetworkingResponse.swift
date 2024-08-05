//
//  SwiftyNetworkingResponse.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

public struct SwiftyNetworkingResponse: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let code: Int
    public let headers: [String: String]
    public let body: Data
    public let fetchType: FetchType?
    public let start: Date?
    public let end: Date?
    
    init(
        id: UUID = UUID(),
        rawValue: HTTPURLResponse,
        body: Data,
        fetchType: FetchType? = nil,
        start: Date? = nil,
        end: Date? = nil
    ) {
        self.id = id
        self.code = rawValue.statusCode
        self.headers = rawValue.allHeaderFields.reduce(into: [String: String]()) { result, header in
            if let name = header.key as? String, let value = header.value as? String {
                result[name] = value
            }
        }
        self.body = body
        self.fetchType = fetchType
        self.start = start
        self.end = end
    }
}
