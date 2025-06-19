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
}
