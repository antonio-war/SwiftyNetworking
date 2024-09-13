//
//  SwiftyNetworkingDelegateTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingDelegateTests: XCTestCase {
    
//    var delegate: SwiftyNetworkingDelegate!
//    var client: SwiftyNetworkingClient!
//    
//    override func setUpWithError() throws {
//        delegate = SwiftyNetworkingDelegate(cache: NSCache(countLimit: 1))
//        client = SwiftyNetworkingClient(configuration: .default, delegate: delegate)
//    }
//    
//    override func tearDownWithError() throws {
//        delegate = nil
//        client = nil
//    }
//    
//    func testCacheWhenMetricsAreNotAvailable() throws {
//        let url = try XCTUnwrap(URL(string: "http://valid-endpoint/valid-path?id=1"))
//        let request = URLRequest(url: url)
//        XCTAssertNil(delegate.fetchType(for: request))
//        XCTAssertNil(delegate.start(for: request))
//        XCTAssertNil(delegate.end(for: request))
//    }
//    
//    func testCacheWhenMetricsAreAvailable() async throws {
//        let request = JsonPlaceholderRouter.users
//        let response = try await client.send(request)
//        let rawRequest = try request.rawValue.rawValue
//        XCTAssertEqual(response.status, .success)
//        XCTAssertNotNil(delegate.fetchType(for: rawRequest))
//        XCTAssertNotNil(delegate.start(for: rawRequest))
//        XCTAssertNotNil(delegate.end(for: rawRequest))
//    }
//    
//    func testCacheIsCleanedWhenTheLimitIsReached() async throws {
//        let firstRequest = JsonPlaceholderRouter.users
//        let firstRawRequest = try firstRequest.rawValue.rawValue
//        let firstResponse = try await client.send(firstRequest)
//        let secondRequest = JsonPlaceholderRouter.user(id: 1)
//        let _ = try await client.send(secondRequest)
//        XCTAssertEqual(firstResponse.status, .success)
//        XCTAssertNil(delegate.fetchType(for: firstRawRequest))
//        XCTAssertNil(delegate.start(for: firstRawRequest))
//        XCTAssertNil(delegate.end(for: firstRawRequest))
//    }
}
