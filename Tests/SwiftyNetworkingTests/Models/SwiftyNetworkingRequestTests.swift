//
//  SwiftyNetworkingRequestTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingRequestTests: XCTestCase {
    
    func testUrlWhenEndpointIsInvalid() {
        let request = SwiftyNetworkingRequest(endpoint: "")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenSchemeIsInvalid() {
        let request = SwiftyNetworkingRequest(endpoint: "ftp://invalid-endpoint")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenPathIsValid() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", path: "valid-path")
        XCTAssertNoThrow(try request.url)
    }
    
    func testUrlWhenPathIsInvalid() {
        let request = SwiftyNetworkingRequest(endpoint: "valid-path", path: "http://valid-endpoint")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenParametersAreEmpty() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint")
        XCTAssertNoThrow(try request.url)
    }
    
    func testUrlWhenParametersAreNotEmpty() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", parameters: ["id": "1"])
        XCTAssertNoThrow(try request.url)
        XCTAssertEqual(request.parameters, ["id": "1"])
    }
    
    func testRawValue() throws {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", path: "valid-path", parameters: ["id": "1"])
        let rawValue = try XCTUnwrap(request.rawValue)
        XCTAssertEqual(rawValue.url?.absoluteString, "http://valid-endpoint/valid-path?id=1")
        XCTAssertEqual(rawValue.httpMethod, "GET")
        XCTAssertEqual(rawValue.allHTTPHeaderFields, [:])
        XCTAssertEqual(rawValue.httpBody, nil)
        XCTAssertEqual(rawValue.timeoutInterval, 60)
    }
}
