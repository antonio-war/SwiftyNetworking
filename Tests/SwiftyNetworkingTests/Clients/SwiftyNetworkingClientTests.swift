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
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
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
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenParametersAreNotEmpty() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "comments",
            method: .get,
            parameters: ["postId": "1"],
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
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
        let firstDuration = try XCTUnwrap(firstResponse.duration)
        XCTAssertEqual(firstResponse.fetchType, .networkLoad)
        
        let secondRequest = SwiftyNetworkingRequest(
            endpoint: "https://jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .returnCacheDataElseLoad
        )
        let secondResponse = try await networkingClient.send(secondRequest)
        let secondDuration = try XCTUnwrap(secondResponse.duration)
        XCTAssertEqual(secondResponse.fetchType, .localCache)
        XCTAssertLessThanOrEqual(secondDuration, firstDuration)
    }
    
    func testSendGetRequestWhenStatusIsRedirection() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "status/300",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 300)
        XCTAssertEqual(response.status, .redirection)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertTrue(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenStatusIsClientError() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "status/400",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 400)
        XCTAssertEqual(response.status, .clientError)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertTrue(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenStatusIsServerError() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "status/500",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 500)
        XCTAssertEqual(response.status, .serverError)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertTrue(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenStatusIsInvalid() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "status/600",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 600)
        XCTAssertEqual(response.status, .invalid)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertTrue(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
    
    func testSendGetRequestWhenUrlIsInvalid() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "http://valid-endpoint",
            path: "valid-path",
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        await XCTAssertThrowsError(try await networkingClient.send(request))
    }
    
    func testSendPatchRequest() async throws {
        let request = SwiftyNetworkingRequest(
            endpoint: "https://httpbin.org",
            path: "patch",
            method: .patch,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
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
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
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
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.status, .success)
        XCTAssertEqual(response.fetchType, .networkLoad)
        XCTAssertFalse(response.body.isEmpty)
        XCTAssertFalse(response.headers.isEmpty)
    }
}
