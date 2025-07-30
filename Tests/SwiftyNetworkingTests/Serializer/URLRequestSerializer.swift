//
//  URLRequestSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/07/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct URLResultSerializerTests {
    private let serializer: URLRequestSerializer = URLRequestSerializer()
    
    @Test
    func urlWhenQueryParametersAreEmptyThenItShouldReturnInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = NetworkingRequest(url: url)
        let serialized = serializer.url(request)
        #expect(url == serialized)
    }
    
    @Test
    func urlWhenQueryParametersAreNotEmptyThenItShouldReturnDifferentUrl() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let expectedUrl = try #require(URL(string: "www.example.com?key=value"))
        let request = NetworkingRequest(url: url, queryParameters: ["key": "value"])
        let serialized = serializer.url(request)
        #expect(serialized == expectedUrl)
    }
}
