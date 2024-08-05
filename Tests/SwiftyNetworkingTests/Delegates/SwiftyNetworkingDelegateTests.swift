//
//  SwiftyNetworkingDelegateTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingDelegateTests: XCTestCase {
    
    var networkingDelegate: SwiftyNetworkingDelegate!
    var client: SwiftyNetworkingClient!
    
    override func setUpWithError() throws {
        networkingDelegate = SwiftyNetworkingDelegate(cache: NSCache(countLimit: 1))
        client = SwiftyNetworkingClient(configuration: .default, delegate: networkingDelegate)
    }
    
    override func tearDownWithError() throws {
        networkingDelegate = nil
        client = nil
    }
    
    func testCacheWhenMetricsAreNotAvailable() throws {
        let url = try XCTUnwrap(URL(string: "http://valid-endpoint/valid-path?id=1"))
        let request = URLRequest(url: url)
        XCTAssertNil(networkingDelegate.fetchType(for: request))
        XCTAssertNil(networkingDelegate.start(for: request))
        XCTAssertNil(networkingDelegate.end(for: request))
    }
    
    func testCacheWhenMetricsAreAvailable() async throws {
        let request = JsonPlaceholderRouter.users
        let response = try await client.send(request)
        let rawRequest = try request.rawValue.rawValue
        XCTAssertEqual(response.status, .success)
        XCTAssertNotNil(networkingDelegate.fetchType(for: rawRequest))
        XCTAssertNotNil(networkingDelegate.start(for: rawRequest))
        XCTAssertNotNil(networkingDelegate.end(for: rawRequest))
    }
    
    func testCacheIsCleanedWhenTheLimitIsReached() async throws {
        let firstRequest = JsonPlaceholderRouter.users
        let firstRawRequest = try firstRequest.rawValue.rawValue
        let firstResponse = try await client.send(firstRequest)
        let secondRequest = JsonPlaceholderRouter.user(id: 1)
        let _ = try await client.send(secondRequest)
        XCTAssertEqual(firstResponse.status, .success)
        XCTAssertNil(networkingDelegate.fetchType(for: firstRawRequest))
        XCTAssertNil(networkingDelegate.start(for: firstRawRequest))
        XCTAssertNil(networkingDelegate.end(for: firstRawRequest))
    }
}
