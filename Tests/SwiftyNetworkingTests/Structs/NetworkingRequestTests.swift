//
//  NetworkingRequestTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 12/07/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct NetworkingRequestTests {
    
    @Test
    func urlWhenRawValueHasNotQueryItemsThenItShouldBeEqualToInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = NetworkingRequest(url: url)
        #expect(request.url == url)
    }
    
    @Test
    func urlWhenRawValueHasQueryItemsThenItShouldBeDifferentFromInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let expectedUrl = try #require(URL(string: "www.example.com"))
        let request = NetworkingRequest(url: url)
        #expect(request.url == expectedUrl)
    }
    
    @Test
    func queryParametersWhenRawValueIsEmptyAndUrlHasNotQueryItemsThenItShouldBeEmpty() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = NetworkingRequest(url: url, queryParameters: [:])
        #expect(request.queryParameters.isEmpty)
    }
    
    @Test
    func queryParametersWhenRawValueIsEmptyButUrlHasQueryItemsThenItShouldBeNotEmpty() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = NetworkingRequest(url: url, queryParameters: [:])
        #expect(request.queryParameters == ["key": "value"])
    }
    
    @Test
    func queryParametersWhenRawValueIsNotEmptyAndUrlHasQueryItemsThenItShouldBeNotEmpty() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = NetworkingRequest(url: url, queryParameters: ["example": "test"])
        #expect(request.queryParameters == ["key": "value", "example": "test"])
    }
    
    @Test
    func schemeWhenRawValueIsNilThenItShouldBeNil() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = NetworkingRequest(url: url)
        #expect(request.scheme == nil)
    }
    
    @Test
    func schemeWhenRawValueIsHttpThenItShouldBeNotNil() async throws {
        let url = try #require(URL(string: "http://www.example.com?key=value"))
        let request = NetworkingRequest(url: url)
        #expect(request.scheme == .http)
    }
    
    @Test
    func schemeWhenRawValueIsHttpsThenItShouldBeNotNil() async throws {
        let url = try #require(URL(string: "https://www.example.com?key=value"))
        let request = NetworkingRequest(url: url)
        #expect(request.scheme == .https)
    }
}
