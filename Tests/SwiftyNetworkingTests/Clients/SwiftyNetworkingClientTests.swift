//
//  SwiftyNetworkingClientTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import Testing

@Suite struct SwiftyNetworkingClientTests {
    let networkingClient: SwiftyNetworkingClient
    
    init() {
        self.networkingClient = SwiftyNetworkingClient()
    }
    
    @Test func sendDeleteRequest() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "delete",
            method: .delete,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendGetRequest() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "get",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }

    @Test func sendGetRequestWhenParametersAreNotEmpty() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "jsonplaceholder.typicode.com",
            path: "comments",
            parameters: ["postId": "1"],
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendGetRequestWhenCacheIsEnabled() async throws {
        let firstRequest = try SwiftyNetworkingRequest(
            host: "jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .reloadIgnoringCacheData
        )
        let firstResponse = try await networkingClient.send(firstRequest)
        let firstDuration = try #require(firstResponse.duration)
        #expect(firstResponse.fetchType == .networkLoad)
        
        let secondRequest = try SwiftyNetworkingRequest(
            host: "jsonplaceholder.typicode.com",
            path: "todos/1",
            method: .get,
            cachePolicy: .returnCacheDataElseLoad
        )
        let secondResponse = try await networkingClient.send(secondRequest)
        let secondDuration = try #require(secondResponse.duration)
        #expect(secondResponse.fetchType == .localCache)
        #expect(secondDuration <= firstDuration)
    }
    
    @Test func sendGetRequestWhenStatusIsRedirection() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "status/300",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 300)
        #expect(response.status == .redirection)
        #expect(response.fetchType == .networkLoad)
        #expect(response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }

    @Test func sendGetRequestWhenStatusIsClientError() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "status/400",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 400)
        #expect(response.status == .clientError)
        #expect(response.fetchType == .networkLoad)
        #expect(response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendGetRequestWhenStatusIsServerError() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "status/500",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 500)
        #expect(response.status == .serverError)
        #expect(response.fetchType == .networkLoad)
        #expect(response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }

    @Test func sendGetRequestWhenStatusIsInvalid() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "status/600",
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 600)
        #expect(response.status == .invalid)
        #expect(response.fetchType == .networkLoad)
        #expect(response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendGetRequestWhenUrlIsInvalid() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "valid-endpoint",
            path: "valid-path",
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        await #expect(throws: Error.self) {
            try await networkingClient.send(request)
        }
    }
    
    @Test func sendGetRequestWithDecoding() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "jsonplaceholder.typicode.com",
            path: "/users",
            cachePolicy: .reloadIgnoringCacheData
        )
        let users = try await networkingClient.send(request, decoding: [JsonPlaceholderUser].self)
        #expect(!users.isEmpty)
    }
    
    @Test func sendGetRequestWithDecodingWhenStatusIsInvalid() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "status/600",
            cachePolicy: .reloadIgnoringCacheData
        )
        await #expect(throws: Error.self) {
            try await networkingClient.send(request, decoding: [JsonPlaceholderUser].self)
        }
    }
    
    @Test func sendGetRequestWithDecodingWhenModelIsInvalid() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.jsonplaceholder.typicode.com",
            path: "/users",
            cachePolicy: .reloadIgnoringCacheData
        )
        await #expect(throws: Error.self) {
            try await networkingClient.send(request, decoding: [JsonPlaceholderInvalidUser].self)
        }
    }
    
    @Test func sendGetRequestUsingRouter() async throws {
        let request = try JsonPlaceholderRouter.users.request
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendGetRequestWithDecodingUsingRouter() async throws {
        let request = try JsonPlaceholderRouter.users.request
        let users = try await networkingClient.send(request, decoding: [JsonPlaceholderUser].self)
        #expect(!users.isEmpty)
    }
    
    @Test func sendPatchRequest() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "patch",
            method: .patch,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }

    @Test func sendPostRequest() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "post",
            method: .post,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
    
    @Test func sendPutRequest() async throws {
        let request = try SwiftyNetworkingRequest(
            host: "www.httpbin.org",
            path: "put",
            method: .put,
            cachePolicy: .reloadIgnoringCacheData
        )
        let response = try await networkingClient.send(request)
        #expect(response.code == 200)
        #expect(response.status == .success)
        #expect(response.fetchType == .networkLoad)
        #expect(!response.body.isEmpty)
        #expect(!response.headers.isEmpty)
    }
}
