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
    func statusWhenCodeIs150ThenItShouldBeInformation() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 150, body: Data(), contentLength: 0)
        #expect(response.status == .information)
    }
    
    @Test
    func statusWhenCodeIs200ThenItShouldBeSuccess() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 200, body: Data(), contentLength: 0)
        #expect(response.status == .success)
    }
    
    @Test
    func statusWhenCodeIs320ThenItShouldBeRedirection() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 320, body: Data(), contentLength: 0)
        #expect(response.status == .redirection)
    }
    
    @Test
    func statusWhenCodeIs450ThenItShouldBeClientError() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 450, body: Data(), contentLength: 0)
        #expect(response.status == .clientError)
    }
    
    @Test
    func statusWhenCodeIs530ThenItShouldBeServerError() async throws {
        let url = try #require(URL(string: "www.example.com"))
        let response = NetworkingResponse(url: url, code: 530, body: Data(), contentLength: 0)
        #expect(response.status == .serverError)
    }
}
