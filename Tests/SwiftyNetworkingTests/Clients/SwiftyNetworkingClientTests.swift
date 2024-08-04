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
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "get",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenParametersAreNotEmpty() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "comments",
            method: .get,
            parameters: ["postId": 1],
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenCacheIsEnabled() async throws {
        let firstRequest = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let firstResponse = try await networkingClient.send(firstRequest)
        XCTAssertEqual(firstResponse.source, .network)
        
        let secondRequest = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .returnCacheDataElseLoad
        )
        let secondResponse = try await networkingClient.send(secondRequest)
        XCTAssertEqual(secondResponse.source, .cache)
        XCTAssertLessThanOrEqual(secondResponse.duration, firstResponse.duration)
    }
    
    func testSendPatchRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "patch",
            method: .patch,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendPostRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "post",
            method: .post,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendPutRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "put",
            method: .put,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.status, 200)
        XCTAssertEqual(response.source, .network)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
}
