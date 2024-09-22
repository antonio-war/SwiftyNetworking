//
//  SwiftyNetworkingRouterTests.swift
//  
//
//  Created by Antonio Guerra on 04/08/24.
//

@testable import SwiftyNetworking
import Testing

@Suite struct SwiftyNetworkingRouterTests {
    
    @Test func requestIsSuccessfullyInitializedWhenPathIsStatic() throws {
        let request = try JsonPlaceholderRouter.users.request
        #expect(request.scheme == .https)
        #expect(request.host == "jsonplaceholder.typicode.com")
        #expect(request.path == "/users/")
        #expect(request.method == .get)
        #expect(request.headers == [:])
        #expect(request.body == nil)
        #expect(request.parameters == [:])
        #expect(request.cachePolicy == .reloadIgnoringLocalCacheData)
        #expect(request.timeout == 60)
    }
    
    @Test(arguments: [1, 2, 3]) func requestIsSuccessfullyInitializedWhenPathIsDynamic(_ id: Int) throws {
        let request = try JsonPlaceholderRouter.user(id: id).request
        #expect(request.scheme == .https)
        #expect(request.host == "jsonplaceholder.typicode.com")
        #expect(request.path == "/users/\(id)")
        #expect(request.method == .get)
        #expect(request.headers == [:])
        #expect(request.body == nil)
        #expect(request.parameters == [:])
        #expect(request.cachePolicy == .reloadIgnoringLocalCacheData)
        #expect(request.timeout == 60)
    }
}
