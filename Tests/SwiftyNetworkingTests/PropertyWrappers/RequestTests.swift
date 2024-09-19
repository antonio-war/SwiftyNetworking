//
//  RequestTests.swift
//  
//
//  Created by Antonio Guerra on 18/09/24.
//

import SwiftyNetworking
import XCTest

final class RequestTests: XCTestCase {
    
    func testInitFromURL() {
        @Request(url: URL(string: "https://jsonplaceholder.typicode.com/users"))
        var users: [JsonPlaceholderUser]?
        XCTAssertNil(users)
    }
    
    func testInitFromString() {
        @Request(url: "https://jsonplaceholder.typicode.com/users")
        var users: [JsonPlaceholderUser]?
        XCTAssertNil(users)
    }
}
