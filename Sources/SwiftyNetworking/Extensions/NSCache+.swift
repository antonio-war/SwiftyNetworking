//
//  NSCache+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation

public extension NSCache {
    @objc convenience init(countLimit: Int) {
        self.init()
        self.countLimit = countLimit
        self.evictsObjectsWithDiscardedContent = true
    }
}
