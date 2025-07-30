//
//  NetworkingResponse.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 16/05/25.
//

import Foundation

public struct NetworkingResponse: Sendable, RawRepresentable {
    public let url: URL
    public let code: Int
    public let headers: [String: String]
    public let body: Data
    public let contentLength: Int
    public let mimeType: NetworkingMimeType?
    public let encoding: NetworkingEncoding?
    public internal(set) var metric: NetworkingMetric?
    
    public init(
        url: URL,
        code: Int,
        headers: [String: String] = [:],
        body: Data,
        contentLength: Int,
        mimeType: NetworkingMimeType? = nil,
        encoding: NetworkingEncoding? = nil
    ) {
        self.url = url
        self.code = code
        self.headers = headers
        self.body = body
        self.contentLength = contentLength
        self.mimeType = mimeType
        self.encoding = encoding
    }
    
    public init?(rawValue: (data: Data, urlResponse: URLResponse)) {
        guard let response = deserializer.deserialize(rawValue) else { return nil }
        self.url = response.url
        self.code = response.code
        self.headers = response.headers
        self.body = response.body
        self.contentLength = response.contentLength
        self.mimeType = response.mimeType
        self.encoding = response.encoding
    }
    
    public var rawValue: (data: Data, urlResponse: URLResponse) {
        return serializer.serialize(self)
    }
    
    public var status: NetworkingResponseStatus {
        return switch code {
        case 100 ... 199: .information
        case 200 ... 299: .success
        case 300 ... 399: .redirection
        case 400 ... 499: .clientError
        case 500 ... 599: .serverError
        default: .invalid
        }
    }
    
    private let serializer: URLSessionTaskResultSerializer = URLSessionTaskResultSerializer()
    private let deserializer: URLSessionTaskResultDeserializer = URLSessionTaskResultDeserializer()
}
