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
        let request = ExampleSwiftyNetworkingRouter.users.rawValue
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
        let request = ExampleSwiftyNetworkingRouter.user(id: 1).rawValue
        XCTAssertEqual(request.endpoint, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(request.path, "/1")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.body, nil)
        XCTAssertEqual(request.parameters, [:])
        XCTAssertEqual(request.cachePolicy, .returnCacheDataElseLoad)
        XCTAssertEqual(request.timeout, 60)
    }

    private enum ExampleSwiftyNetworkingRouter: SwiftyNetworkingRouter {
        case users
        case user(id: Int)
        
        var endpoint: String {
            "https://jsonplaceholder.typicode.com"
        }
        
        var path: String {
            switch self {
            case .users:
                "/"
            case .user(let id):
                "/\(id)"
            }
        }
    }
}
