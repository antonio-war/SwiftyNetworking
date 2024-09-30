//
//  SwiftyNetworkingDelegateTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite struct SwiftyNetworkingDelegateTests {
    let delegate: SwiftyNetworkingDelegate
    let client: SwiftyNetworkingClient
    
    init() {
        self.delegate = SwiftyNetworkingDelegate(cache: NSCache(countLimit: 1))
        self.client = SwiftyNetworkingClient(configuration: .default, delegate: delegate)
    }
    
    @Test func cacheWhenMetricsAreNotAvailable() throws {
        let url = try #require(URL(string: "http://valid-endpoint/valid-path?id=1"))
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        #expect(delegate.fetchType(for: request) == nil)
        #expect(delegate.start(for: request) == nil)
        #expect(delegate.end(for: request) == nil)
    }
    
    @Test func cacheWhenMetricsAreAvailable() async throws {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/")
        let request = try SwiftyNetworkingRequest(url: url)
        let response = try await client.send(request)
        #expect(response.status == .success)
        #expect(delegate.fetchType(for: request.rawValue) != nil)
        #expect(delegate.start(for: request.rawValue) != nil)
        #expect(delegate.end(for: request.rawValue) != nil)
    }
    
    @Test func cacheIsCleanedWhenTheLimitIsReached() async throws {
        let firstUrl = URL(string: "https://jsonplaceholder.typicode.com/users/")
        let firstRequest = try SwiftyNetworkingRequest(url: firstUrl)
        let firstResponse = try await client.send(firstRequest)
        let secondUrl = URL(string: "https://jsonplaceholder.typicode.com/users/1")
        let secondRequest = try SwiftyNetworkingRequest(url: secondUrl)
        let _ = try await client.send(secondRequest)
        #expect(firstResponse.status == .success)
        #expect(delegate.fetchType(for: firstRequest.rawValue) == nil)
        #expect(delegate.start(for: firstRequest.rawValue) == nil)
        #expect(delegate.end(for: firstRequest.rawValue) == nil)
    }
}
