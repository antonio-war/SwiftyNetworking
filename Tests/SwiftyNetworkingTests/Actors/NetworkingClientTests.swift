//
//  NetworkingClientTests.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite
struct NetworkingClientTests {
    private let client: NetworkingClient = .shared
    
    @Test func sendWhenMethodIsDeleteThenResponseStatusShouldBeSuccess() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/delete"))
        let request = NetworkingRequest(url: url, method: .delete, cachePolicy: .reloadIgnoringCacheData)
        let response = try await client.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.mimeType == .json)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
        #expect(response.metric?.source == .network)
        #expect(response.metric?.standard == .http2)
    }
    
    @Test func sendWhenMethodIsGetThenResponseStatusShouldBeSuccess() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/get"))
        let request = NetworkingRequest(url: url, method: .get, cachePolicy: .reloadIgnoringCacheData)
        let response = try await client.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.mimeType == .json)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
        #expect(response.metric?.source == .network)
        #expect(response.metric?.standard == .http2)
    }
    
    @Test func sendWhenMethodIsGetAndParametersAreNotEmptyThenResponseStatusShouldBeSuccess() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/get"))
        let request = NetworkingRequest(
            url: url,
            method: .get,
            queryParameters: ["postId": "1"],
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.mimeType == .json)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
        #expect(response.metric?.source == .network)
        #expect(response.metric?.standard == .http2)
    }
    
    @Test func sendWhenMethodIsGetAndStatusIsRedirectionThenResponseStatusShouldBeSuccess() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/status/300"))
        let request = NetworkingRequest(
            url: url,
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request)
        #expect(response.code == 300)
        #expect(response.status == .redirection)
        #expect(response.mimeType == .html)
        #expect(response.body.isEmpty)
        #expect(!response.headers.isEmpty)
        #expect(response.metric?.source == .network)
        #expect(response.metric?.standard == .http2)
    }
    
    @Test func sendWhenMethodIsGetAndRequestsAreParallelThenResponsesShouldBeSuccessful() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/get"))
        let request = NetworkingRequest(url: url, method: .get, cachePolicy: .reloadIgnoringCacheData)
        try await withThrowingTaskGroup { group in
            for _ in 0..<10 {
                group.addTask {
                    try await client.send(request)
                }
            }
            for try await response in group {
                #expect(response.code == 200)
                #expect(response.status == .success)
                #expect(response.mimeType == .json)
                #expect(!response.body.isEmpty)
                #expect(!response.headers.isEmpty)
                #expect(response.metric?.source == .network)
                #expect(response.metric?.standard == .http2)
            }
        }
    }
    
    @Test func sendWhenMethodIsGetAndCacheIsEnabledThenResponseShouldBeCached() async throws {
        let url = try #require(URL(string: "https://www.httpbin.org/get"))
        let request = NetworkingRequest(url: url, method: .get, cachePolicy: .returnCacheDataElseLoad)
        let _ = try await client.send(request)
        let response = try await client.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.mimeType == .json)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
        #expect(response.metric?.source == .cache)
        #expect(response.metric?.standard == nil)
    }
    
    @Test func sendWhenUrlIsNotAnHttpUrlThenInvalidRequestErrorShouldBeThrown() async throws {
        let url = try #require(URL(string: "ftp://www.httpbin.org/get"))
        let request = NetworkingRequest(url: url, method: .get, cachePolicy: .reloadIgnoringCacheData)
        await #expect(throws: NetworkingError.invalidRequest) {
            try await client.send(request)
        }
    }
}
