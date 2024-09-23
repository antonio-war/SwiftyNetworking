//
//  SwiftyNetworkingResponseTests.swift
//  
//
//  Created by Antonio Guerra on 06/08/24.
//

import Foundation
@testable import SwiftyNetworking
import Testing

@Suite struct SwiftyNetworkingResponseTests {

    let delegate: SwiftyNetworkingDelegate
    let client: SwiftyNetworkingClient
    
    init() {
        self.delegate = SwiftyNetworkingDelegate(cache: NSCache(countLimit: 1))
        self.client = SwiftyNetworkingClient(configuration: .default, delegate: delegate)
    }
    
    @Test func durationIsSuccessfullyInitialized() async throws {
        let request = try SwiftyNetworkingRequest(
            url: URL(string: "https://httpbin.org/get"),
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request)
        let start = try #require(response.start)
        let end = try #require(response.end)
        let duration = try #require(response.duration)
        #expect(duration == end.timeIntervalSince(start))
    }
}
