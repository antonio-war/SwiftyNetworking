//
//  SwiftyNetworkingRouterTests.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingRouterTests: XCTestCase {

    func testRawValueWhenCaseHasNotAssociatedParameters() throws {
        let request = try JsonPlaceholderRouter.users.request
        XCTAssertEqual(request.scheme, .https)
        XCTAssertEqual(request.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(request.path, "/users/")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.parameters, [:])
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalCacheData)
        XCTAssertEqual(request.timeout, 60)
    }
    
    func testRawValueWhenCaseHasAssociatedParameters() throws {
        let request = try JsonPlaceholderRouter.user(id: 1).request
        XCTAssertEqual(request.scheme, .https)
        XCTAssertEqual(request.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(request.path, "/users/1")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.parameters, [:])
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalCacheData)
        XCTAssertEqual(request.timeout, 60)
    }
}
