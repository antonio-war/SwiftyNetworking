//
//  SwiftyNetworkingClientTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingClientTests: XCTestCase {
    
    var networkingClient: SwiftyNetworkingClient!
    
    override func setUpWithError() throws {
        networkingClient = SwiftyNetworkingClient()
    }
    
    override func tearDownWithError() throws {
        networkingClient = nil
    }
    
    func testSendDeleteRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "delete",
            method: .delete,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendGetRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "get",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPatchRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "patch",
            method: .patch,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPostRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "post",
            method: .post,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendPutRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "put",
            method: .put,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request: request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.body.isEmpty)
    }
    
    func testSendGetRequestReturnsCachedResponseWhenNeeded() async throws {
        let firstRequest = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let firstResponse = try await networkingClient.send(request: firstRequest)
        XCTAssertEqual(firstResponse.source, .network)
        
        let secondRequest = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .returnCacheDataElseLoad
        )
        let secondResponse = try await networkingClient.send(request: secondRequest)
        XCTAssertEqual(secondResponse.source, .cache)
        XCTAssertLessThanOrEqual(secondResponse.duration, firstResponse.duration)
    }
}
