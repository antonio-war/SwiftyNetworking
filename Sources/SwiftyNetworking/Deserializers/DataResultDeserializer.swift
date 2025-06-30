//
//  DataResultDeserializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

struct DataResultDeserializer: Sendable {
    
    func deserialize(_ result: (data: Data, urlResponse: URLResponse)) -> NetworkingResponse? {
        guard let url = url(result) else { return nil }
        guard let code = code(result) else { return nil }
        return NetworkingResponse(
            url: url,
            code: code,
            headers: headers(result),
            body: body(result),
            contentLenght: contentLenght(result),
            mimeType: mimeType(result)
        )
    }
    
    func url(_ result: (data: Data, urlResponse: URLResponse)) -> URL? {
        guard let response = result.urlResponse as? HTTPURLResponse else { return nil }
        return response.url
    }
    
    func code(_ result: (data: Data, urlResponse: URLResponse)) -> Int? {
        guard let response = result.urlResponse as? HTTPURLResponse else { return nil }
        return response.statusCode
    }
    
    func headers(_ result: (data: Data, urlResponse: URLResponse)) -> [String: String] {
        guard let response = result.urlResponse as? HTTPURLResponse else { return [:] }
        return response.allHeaderFields.reduce(into: [String: String]()) { dict, pair in
            if let key = pair.key as? String, let value = pair.value as? String {
                dict[key] = value
            }
        }
    }
    
    func body(_ result: (data: Data, urlResponse: URLResponse)) -> Data {
        return result.data
    }
    
    func contentLenght(_ result: (data: Data, urlResponse: URLResponse)) -> Int {
        return Int(result.urlResponse.expectedContentLength)
    }
    
    func mimeType(_ result: (data: Data, urlResponse: URLResponse)) -> NetworkingMimeType? {
        guard let rawValue = result.urlResponse.mimeType else { return nil }
        return NetworkingMimeType(rawValue: rawValue.uppercased())
    }
}
