//
//  NetworkingError.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

public enum NetworkingError: Error {
    case invalidResponse
    case unexpected(_ error: Error)
}
