//
//  SwiftyNetworkingCachePolicyTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingCachePolicyTests: XCTestCase {

    func testReloadIgnoringCacheData() {
        let cachePolicy = SwiftyNetworkingCachePolicy.reloadIgnoringCacheData
        XCTAssertEqual(cachePolicy.underlyingCachePolicy, .reloadIgnoringLocalCacheData)
    }
    
    func testReturnCacheDataElseLoad() {
        let cachePolicy = SwiftyNetworkingCachePolicy.returnCacheDataElseLoad
        XCTAssertEqual(cachePolicy.underlyingCachePolicy, .returnCacheDataElseLoad)
    }
    
    func testReturnCacheDataDontLoad() {
        let cachePolicy = SwiftyNetworkingCachePolicy.returnCacheDataDontLoad
        XCTAssertEqual(cachePolicy.underlyingCachePolicy, .returnCacheDataDontLoad)
    }
}
