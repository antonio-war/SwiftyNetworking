//
//  SwiftyNetworkingClientTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingClientTests: XCTestCase {
    
    func testSendGetRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://freetestapi.com",
            path: "api/v1/movies",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    
}
