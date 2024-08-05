//
//  SwiftyNetworkingResponse+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation

public extension SwiftyNetworkingResponse {
    
    var duration: TimeInterval? {
        guard let start, let end else {
            return nil
        }
        return end.timeIntervalSince(start)
    }
}
