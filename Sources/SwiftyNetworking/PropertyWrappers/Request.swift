//
//  Request.swift
//
//
//  Created by Antonio Guerra on 14/09/24.
//

import Combine
import Foundation
import SwiftUI

@propertyWrapper
public struct Request<Model: Decodable>: DynamicProperty {
    public typealias Method = SwiftyNetworkingRequest.Method
    @State private var model: Model?
    @State private var error: Error?
    
    let client: SwiftyNetworkingClient
    let url: URL?
    let method: Method
    let headers: [String: String]
    let body: Data?
    let cachePolicy: CachePolicy
    let timeout: TimeInterval
    let decoder: JSONDecoder
    
    public init(
        client: SwiftyNetworkingClient = SwiftyNetworkingClient(),
        url: URL?,
        method: Method = .get,
        headers: [String : String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.client = client
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
        self.decoder = decoder
    }
    
    public init(
        client: SwiftyNetworkingClient = SwiftyNetworkingClient(),
        url: String,
        method: Method = .get,
        headers: [String : String] = [:],
        body: Data? = nil,
        cachePolicy: CachePolicy = .returnCacheDataElseLoad,
        timeout: TimeInterval = 60,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.init(
            client: client,
            url: URL(
                string: url
            ),
            method: method,
            headers: headers,
            body: body,
            cachePolicy: cachePolicy,
            timeout: timeout,
            decoder: decoder
        )
    }
    
    public var wrappedValue: Model? {
        model
    }
        
    private var shouldUpdate: Bool {
        model == nil || error != nil
    }
    
    @MainActor
    func fetch() async {
        do {
            let request = try SwiftyNetworkingRequest(
                url: url,
                method: method,
                headers: headers,
                body: body,
                cachePolicy: cachePolicy,
                timeout: timeout
            )
            self.model = try await client.send(request, decoding: Model.self, using: decoder)
        } catch {
            self.error = error
        }
    }
    
    public func update() {
        guard shouldUpdate else {
            return
        }
        
        Task {
            self.model = nil
            self.error = nil
            await fetch()
        }
    }
}
