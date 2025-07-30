//
//  NetworkingEncoding.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 11/07/25.
//

import Foundation

@frozen
public enum NetworkingEncoding: String, Decodable {
    case utf8 = "UTF-8"
    case utf16 = "UTF-16"
}
