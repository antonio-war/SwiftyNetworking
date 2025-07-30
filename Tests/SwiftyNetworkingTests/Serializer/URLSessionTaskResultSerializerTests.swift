//
//  URLSessionTaskResultSerializerTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/07/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct URLSessionTaskResultSerializerTests {
    private let serializer: URLSessionTaskResultSerializer = URLSessionTaskResultSerializer()
    
    @Test
    func urlResponseWhenMetricIsNilThenItShouldReturnAnHttpUrlResponse() async throws {
        let body = Data("hello".utf8)
        let response = NetworkingResponse(
            url: URL(string: "https://example.com")!,
            code: 0,
            headers: [:],
            body: body,
            contentLength: 5,
            mimeType: .json,
            encoding: .utf8
        )
        let result = serializer.serialize(response)
        #expect(result.data == body)
        #expect(result.urlResponse is HTTPURLResponse)
    }
    
    @Test
    func urlResponseWhenMetricIsNotNilThenItShouldReturnAnHttpUrlResponse() async throws {
        let body = Data("hello".utf8)
        let metric = NetworkingMetric(
            start: Date(),
            end: Date(),
            duration: 0,
            redirections: 0,
            source: .network,
            standard: .http2
        )
        let response = NetworkingResponse(
            url: URL(string: "https://example.com")!,
            code: 0,
            headers: [:],
            body: body,
            contentLength: 5,
            mimeType: .json,
            encoding: .utf8,
            metric: metric
        )
        let result = serializer.serialize(response)
        #expect(result.data == body)
        #expect(result.urlResponse is HTTPURLResponse)
    }
}
