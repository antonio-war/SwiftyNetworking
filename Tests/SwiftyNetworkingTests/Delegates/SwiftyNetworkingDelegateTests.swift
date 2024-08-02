//
//  SwiftyNetworkingDelegateTests.swift
//  
//
//  Created by Antonio Guerra on 02/08/24.
//

@testable import SwiftyNetworking
import XCTest

final class SwiftyNetworkingDelegateTests: XCTestCase {
    
    var networkingDelegate: SwiftyNetworkingDelegate!
    
    override func setUpWithError() throws {
        networkingDelegate = SwiftyNetworkingDelegate()
    }
    
    override func tearDownWithError() throws {
        networkingDelegate = nil
    }
    
    func testMetricsWhenMetricsAreNotAvailable() throws {
        let url = try XCTUnwrap(URL(string: "http://valid-endpoint/valid-path?id=1"))
        let request = URLRequest(url: url)
        let metrics = networkingDelegate.metrics(for: request)
        XCTAssertEqual(metrics.source, .network)
        XCTAssertEqual(metrics.duration, 0)
    }
}
