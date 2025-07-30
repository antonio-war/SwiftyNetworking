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
        guard let httpUrlResponse = httpUrlResponse(response) else {
            return URLResponse(
                url: response.url,
                mimeType: response.mimeType?.rawValue.lowercased(),
                expectedContentLength: response.contentLength,
                textEncodingName: response.encoding?.rawValue.lowercased()
            )
        }
        return httpUrlResponse
    }
    
    func httpUrlResponse(_ response: NetworkingResponse) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: response.url,
            statusCode: response.code,
            httpVersion: response.metric?.standard?.rawValue.lowercased(),
            headerFields: response.headers
        )
    }
}
