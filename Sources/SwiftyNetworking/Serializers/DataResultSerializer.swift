//
//  DataResultSerializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

struct DataResultSerializer: Sendable {
    
    func serialize(_ response: NetworkingResponse) -> (data: Data, urlResponse: URLResponse) {
        return (data: data(response), urlResponse: urlResponse(response))
    }
    
    func data(_ response: NetworkingResponse) -> Data {
        response.body
    }
    
    func urlResponse(_ response: NetworkingResponse) -> URLResponse {
        if let urlResponse = HTTPURLResponse(url: response.url, statusCode: response.code, httpVersion: nil, headerFields: response.headers) {
            return urlResponse
        } else {
            return URLResponse(url: response.url, mimeType: nil, expectedContentLength: response.contentLenght, textEncodingName: nil)
        }
    }
}
