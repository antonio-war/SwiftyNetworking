//
//  URLSession+.swift
//
//
//  Created by Antonio Guerra on 01/08/24.
//

import Foundation

extension URLSession {
    convenience init(configuration: URLSessionConfiguration, delegate: (any URLSessionDelegate)) {
        self.init(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
