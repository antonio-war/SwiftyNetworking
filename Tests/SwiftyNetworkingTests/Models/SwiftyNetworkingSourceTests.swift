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
        let source = SwiftyNetworkingSource(resourceFetchType: resourceFetchType)
        let unwrappedSource = try XCTUnwrap(source)
        XCTAssertEqual(unwrappedSource, .network)
    }
    
    func testCache() throws {
        let resourceFetchType = URLSessionTaskMetrics.ResourceFetchType.localCache
        let source = SwiftyNetworkingSource(resourceFetchType: resourceFetchType)
        let unwrappedSource = try XCTUnwrap(source)
        XCTAssertEqual(unwrappedSource, .cache)
    }
}
