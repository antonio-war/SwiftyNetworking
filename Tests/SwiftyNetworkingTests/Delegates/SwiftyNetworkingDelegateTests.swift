//
//  SwiftyNetworkingDelegateTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingDelegateTests: XCTestCase {
    
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
    
    func testCacheWhenMetricsAreNotAvailable() throws {
        let url = try XCTUnwrap(URL(string: "http://valid-endpoint/valid-path?id=1"))
        let request = URLRequest(url: url)
        XCTAssertNil(delegate.fetchType(for: request))
        XCTAssertNil(delegate.start(for: request))
        XCTAssertNil(delegate.end(for: request))
    }
    
    func testCacheWhenMetricsAreAvailable() async throws {
        let url = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users/"))
        let request = try SwiftyNetworkingRequest(url: url)
        let response = try await client.send(request)
        XCTAssertEqual(response.status, .success)
        XCTAssertNotNil(delegate.fetchType(for: request.rawValue))
        XCTAssertNotNil(delegate.start(for: request.rawValue))
        XCTAssertNotNil(delegate.end(for: request.rawValue))
    }
    
    func testCacheIsCleanedWhenTheLimitIsReached() async throws {
        let firstUrl = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users/"))
        let firstRequest = try SwiftyNetworkingRequest(url: firstUrl)
        let firstResponse = try await client.send(firstRequest)
        let secondUrl = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users/1"))
        let secondRequest = try SwiftyNetworkingRequest(url: secondUrl)
        let _ = try await client.send(secondRequest)
        XCTAssertEqual(firstResponse.status, .success)
        XCTAssertNil(delegate.fetchType(for: firstRequest.rawValue))
        XCTAssertNil(delegate.start(for: firstRequest.rawValue))
        XCTAssertNil(delegate.end(for: firstRequest.rawValue))
    }
}
