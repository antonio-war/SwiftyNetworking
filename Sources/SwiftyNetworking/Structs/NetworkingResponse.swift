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
    public let contentLenght: Int
    public let mimeType: NetworkingMimeType?
    
    public init(
        url: URL,
        code: Int,
        headers: [String: String],
        body: Data,
        contentLenght: Int,
        mimeType: NetworkingMimeType?
    ) {
        self.url = url
        self.code = code
        self.headers = headers
        self.body = body
        self.contentLenght = contentLenght
        self.mimeType = mimeType
    }
    
    public init?(rawValue: (data: Data, urlResponse: URLResponse)) {
        guard let response = deserializer.deserialize(rawValue) else { return nil }
        self.url = response.url
        self.code = response.code
        self.headers = response.headers
        self.body = response.body
        self.contentLenght = response.contentLenght
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
    
    private let serializer: DataResultSerializer = DataResultSerializer()
    private let deserializer: DataResultDeserializer = DataResultDeserializer()
}
