//
//  URLSessionTaskResultSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

struct URLSessionTaskResultSerializer: Sendable {
    
    func serialize(_ response: NetworkingResponse) -> URLSessionTaskResult {
        return (data: data(response), urlResponse: urlResponse(response))
    }
    
    func data(_ response: NetworkingResponse) -> Data {
        response.body
    }
    
    func urlResponse(_ response: NetworkingResponse) -> URLResponse {
        if let urlResponse = HTTPURLResponse(url: response.url, statusCode: response.code, httpVersion: nil, headerFields: response.headers) {
            return urlResponse
        } else {
            return URLResponse(
                url: response.url,
                mimeType: response.mimeType?.rawValue,
                expectedContentLength: response.contentLenght,
                textEncodingName: nil
            )
        }
    }
}
