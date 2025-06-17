//
//  NetworkingRequestBuilderTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 17/06/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct NetworkingRequestBuilderTests {
    
    @Test
    func urlWhenRawValueHasNotQueryItemsThenItShouldBeEqualToInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let request = URLRequest(url: url)
        let builder = try #require(NetworkingRequestBuilder(request))
        #expect(builder.url() == url)
    }
    
    @Test
    func urlWhenRawValueHasQueryItemsThenItShouldBeDifferentFromInitialUrl() async throws {
        let url = try #require(URL(string: "www.example.com?key=value"))
        let request = URLRequest(url: url)
        let builder = try #require(NetworkingRequestBuilder(request))
        #expect(builder.url() != url)
    }
}
