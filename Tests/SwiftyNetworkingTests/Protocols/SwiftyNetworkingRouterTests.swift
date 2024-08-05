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
        let request = TestSwiftyNetworkingRouter.users.rawValue
        XCTAssertEqual(request.endpoint, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(request.path, "/")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.parameters, [:])
        XCTAssertEqual(request.cachePolicy, .returnCacheDataElseLoad)
        XCTAssertEqual(request.timeout, 60)
    }
    
    func testRawValueWhenCaseHasAssociatedParameters() throws {
        let request = TestSwiftyNetworkingRouter.user(id: 1).rawValue
        XCTAssertEqual(request.endpoint, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(request.path, "/1")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.parameters, [:])
        XCTAssertEqual(request.cachePolicy, .returnCacheDataElseLoad)
        XCTAssertEqual(request.timeout, 60)
    }
}
