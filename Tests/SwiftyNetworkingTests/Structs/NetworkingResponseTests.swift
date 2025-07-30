//
//  NetworkingResponseTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/07/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct NetworkingResponseTests {
    
    @Test
    func statusWhenCodeIs200ThenItShouldBeSuccess() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 200, body: Data(), contentLength: 0)
        #expect(response.status == .success)
    }
    
}
