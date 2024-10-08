//
//  Response.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 19/09/24.
//

import Foundation

public enum Response<Model: SwiftyNetworkingModel>: Sendable {
    case loading
    case success(Model)
    case failure(Error)
}
