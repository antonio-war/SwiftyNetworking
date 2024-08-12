//
//  SwiftyNetworkingResponseTests.swift
//  
//
//  Created by Antonio Guerra on 06/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingResponseTests: XCTestCase {
    
    var delegate: SwiftyNetworkingDelegate!
    var client: SwiftyNetworkingClient!
    
    override func setUpWithError() throws {
        delegate = SwiftyNetworkingDelegate(cache: NSCache(countLimit: 1))
        client = SwiftyNetworkingClient(configuration: .default, delegate: delegate)
    }
    
    override func tearDownWithError() throws {
        delegate = nil
        client = nil
    }
    
    func testDuration() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "get",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request)
        let start = try XCTUnwrap(response.start)
        let end = try XCTUnwrap(response.end)
        let duration = try XCTUnwrap(response.duration)
        XCTAssertEqual(duration, end.timeIntervalSince(start))
    }
}
