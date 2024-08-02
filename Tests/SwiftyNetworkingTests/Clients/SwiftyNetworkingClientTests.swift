//
//  SwiftyNetworkingClientTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingClientTests: XCTestCase {
    
    func testSendDeleteRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "delete",
            method: .delete,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendGetRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "get",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPatchRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "patch",
            method: .patch,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPostRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "post",
            method: .post,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPutRequest() async throws {
        let client = SwiftyNetworkingClient()
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "put",
            method: .put,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await client.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
}
