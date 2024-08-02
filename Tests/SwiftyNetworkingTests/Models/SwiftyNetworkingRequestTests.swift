//
//  SwiftyNetworkingRequestTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingRequestTests: XCTestCase {
    
    func testUrlWhenEndpointIsNotValid() {
        let request = SwiftyNetworkingRequest(endpoint: "")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenSchemaIsNotValid() {
        let request = SwiftyNetworkingRequest(endpoint: "ftp://invalid-endpoint")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenPathIsValid() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", path: "valid-path")
        XCTAssertNoThrow(try request.url)
    }
    
    func testUrlWhenPathIsNotValid() {
        let request = SwiftyNetworkingRequest(endpoint: "valid-path", path: "http://valid-endpoint")
        XCTAssertThrowsError(try request.url)
    }
    
    func testUrlWhenParametersAreEmpty() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint")
        XCTAssertNoThrow(try request.url)
    }
    
    func testUrlWhenParametersAreNotEmpty() {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", parameters: ["id": 1])
        XCTAssertNoThrow(try request.url)
        XCTAssertEqual(request.parameters, ["id": "1"])
    }
    
    func testUnderlyingRequest() throws {
        let request = SwiftyNetworkingRequest(endpoint: "http://valid-endpoint", path: "valid-path", parameters: ["id": 1])
        let underlyingRequest = try XCTUnwrap(request.underlyingRequest)
        XCTAssertEqual(underlyingRequest.url?.absoluteString, "http://valid-endpoint/valid-path?id=1")
        XCTAssertEqual(underlyingRequest.httpMethod, "GET")
        XCTAssertEqual(underlyingRequest.allHTTPHeaderFields, [:])
        XCTAssertEqual(underlyingRequest.httpBody, nil)
        XCTAssertEqual(underlyingRequest.timeoutInterval, 60)
    }
}
