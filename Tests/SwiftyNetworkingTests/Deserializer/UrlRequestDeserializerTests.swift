//
//  UrlRequestDeserializerTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct UrlRequestDeserializerTests {
    private let deserializer: URLRequestDeserializer = URLRequestDeserializer()
    
    @Test
    func urlWhenRawValueHasNotQueryItemsThenItShouldBeEqualToInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = URLRequest(url: url)
        let deserializedUrl = try #require(deserializer.url(request))
        #expect(deserializedUrl == url)
    }
    
    @Test
    func urlWhenRawValueHasQueryItemsThenItShouldBeDifferentFromInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = URLRequest(url: url)
        let deserializedUrl = try #require(deserializer.url(request))
        #expect(deserializedUrl != url)
    }
    
    @Test
    func methodWhenRawValueIsValidThenItShouldReturnNetworkingMethod() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let method = try #require(deserializer.method(request))
        #expect(method == .post)
    }
    
    @Test
    func methodWhenRawValueIsNotValidThenItShouldReturnNil() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.httpMethod = "UNKNOWN"
        #expect(deserializer.method(request) == nil)
    }
    
    @Test
    func headersWhenRawValueIsNotEmptyThenItShouldReturnNotEmptyDictionary() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["key": "value"]
        #expect(!deserializer.headers(request).isEmpty)
    }
    
    @Test
    func headersWhenRawValueIsEmptyThenItShouldReturnEmptyDictionary() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [:]
        #expect(deserializer.headers(request).isEmpty)
    }
    
    @Test
    func headersWhenRawValueIsNilThenItShouldReturnEmptyDictionary() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = nil
        #expect(deserializer.headers(request).isEmpty)
    }
    
    @Test
    func queryParametersWhenRawValueIsNotEmptyThenItShouldReturnNotEmptyDictionary() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = URLRequest(url: url)
        let queryParameters = try #require(deserializer.queryParameters(request))
        #expect(!queryParameters.isEmpty)
    }
    
    @Test
    func queryParametersWhenRawValueIsEmptyThenItShouldReturnEmptyDictionary() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = URLRequest(url: url)
        let queryParameters = try #require(deserializer.queryParameters(request))
        #expect(queryParameters.isEmpty)
    }
    
    @Test
    func queryParametersWhenRawValueUrlIsNilThenItShouldReturnNil() async throws {
        let url = try #require(URL(string: "www.example.com"))
        var request = URLRequest(url: url)
        request.url = nil
        #expect(deserializer.queryParameters(request) == nil)
    }
    
    @Test
    func queryParametersWhenRawValueQueryItemsHaveNilValueThenItShouldReturnEmptyDictionary() async throws {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "example.com"
        components.queryItems = [ URLQueryItem(name: "key", value: nil) ]
        let url = try #require(components.url)
        let request = URLRequest(url: url)
        let queryParameters = try #require(deserializer.queryParameters(request))
        #expect(queryParameters.isEmpty)
    }

    @Test
    func bodyWhenRawValueHttpBodyIsNotNilThenItShouldReturnData() async throws {
        var request = URLRequest(url: try #require(URL(string: "https://example.com")))
        request.httpBody = Data()
        #expect(deserializer.body(request) != nil)
    }
}
