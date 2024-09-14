//
//  SwiftyNetworkingRequestTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingRequestTests: XCTestCase {
    
    func testInitFromUrl() throws {
        let url = try XCTUnwrap(URL(string: "https://www.example.com/path?name=test"))
        let request = try SwiftyNetworkingRequest(url: url)
        XCTAssertEqual(request.scheme, .https)
        XCTAssertEqual(request.host, "www.example.com")
        XCTAssertEqual(request.path, "/path")
        XCTAssertEqual(request.parameters, ["name": "test"])
    }
      
    func testInitFromUrlWhenUrlIsInvalid() throws {
        let url = URL(string: "invalid-url")
        XCTAssertThrowsError(try SwiftyNetworkingRequest(url: url))
    }
    
    func testInitFromUrlWhenParametersAreEmpty() throws {
        let url = try XCTUnwrap(URL(string: "https://www.example.com/path"))
        let request = try SwiftyNetworkingRequest(url: url)
        XCTAssertEqual(request.scheme, .https)
        XCTAssertEqual(request.host, "www.example.com")
        XCTAssertEqual(request.path, "/path")
        XCTAssertEqual(request.parameters, [:])
    }
    
    func testInitFromUrlWhenSchemeIsInvalid() throws {
        let url = try XCTUnwrap(URL(string: "ftp://valid-endpoint"))
        XCTAssertThrowsError(try SwiftyNetworkingRequest(url: url))
    }
    
    func testInitFromComponents() throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.example.com",
            path: "/path",
            parameters: ["name": "test"]
        )
        let url = try XCTUnwrap(URL(string: "https://www.example.com/path?name=test"))
        XCTAssertEqual(request.url, url)
    }
     
    func testInitFromComponentsWhenParametersAreEmpty() throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.example.com",
            path: "/path",
            parameters: [:]
        )
        let url = try XCTUnwrap(URL(string: "https://www.example.com/path"))
        XCTAssertEqual(request.url, url)
    }
    
    func testBothInitReturnsTheSameResult() throws {
        let id = UUID()
        let firstRequest = try SwiftyNetworkingRequest(
            id: id,
            url: URL(string: "https://www.example.com/path?name=test")
        )
        let secondRequest = try SwiftyNetworkingRequest(
            id: id,
            scheme: .https,
            host: "www.example.com",
            path: "path",
            parameters: ["name": "test"]
        )
        XCTAssertEqual(firstRequest, secondRequest)
    }
      
    func testRawValue() throws {
        let url = try XCTUnwrap(URL(string: "https://www.example.com/path?name=test"))
        let request = try SwiftyNetworkingRequest(url: url)
        let rawValue = try XCTUnwrap(request.rawValue)
        XCTAssertEqual(rawValue.url?.absoluteString, "https://www.example.com/path?name=test")
        XCTAssertEqual(rawValue.httpMethod, "GET")
        XCTAssertEqual(rawValue.allHTTPHeaderFields, [:])
        XCTAssertEqual(rawValue.httpBody, nil)
        XCTAssertEqual(rawValue.timeoutInterval, 60)
    }
}
