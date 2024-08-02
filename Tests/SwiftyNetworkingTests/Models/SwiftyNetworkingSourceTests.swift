//
//  SwiftyNetworkingSourceTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingSourceTests: XCTestCase {
    
    func testNetwork() throws {
        let resourceFetchType = URLSessionTaskMetrics.ResourceFetchType.networkLoad
        let source = try XCTUnwrap(SwiftyNetworkingSource(resourceFetchType: resourceFetchType))
        XCTAssertEqual(source, .network)
    }
    
    func testCache() throws {
        let resourceFetchType = URLSessionTaskMetrics.ResourceFetchType.localCache
        let source = try XCTUnwrap(SwiftyNetworkingSource(resourceFetchType: resourceFetchType))
        XCTAssertEqual(source, .cache)
    }
}
