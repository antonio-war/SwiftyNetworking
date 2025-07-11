//
//  URLSessionTaskResultDeserializer.swift
//  SwiftyNetworking
//
//  Created by Antonio Guerra on 30/06/25.
//

import Foundation

struct URLSessionTaskResultDeserializer: Sendable {
    
    func deserialize(_ result: URLSessionTaskResult) -> NetworkingResponse? {
        guard let url = url(result) else { return nil }
        guard let code = code(result) else { return nil }
        return NetworkingResponse(
            url: url,
            code: code,
            headers: headers(result),
            body: body(result),
            contentLength: contentLength(result),
            mimeType: mimeType(result),
            encoding: encoding(result)
        )
    }
    
    func url(_ result: URLSessionTaskResult) -> URL? {
        guard let response = result.urlResponse as? HTTPURLResponse else { return nil }
        return response.url
    }
    
    func code(_ result: URLSessionTaskResult) -> Int? {
        guard let response = result.urlResponse as? HTTPURLResponse else { return nil }
        return response.statusCode
    }
    
    func headers(_ result: URLSessionTaskResult) -> [String: String] {
        guard let response = result.urlResponse as? HTTPURLResponse else { return [:] }
        return response.allHeaderFields.reduce(into: [String: String]()) { dict, pair in
            if let key = pair.key as? String, let value = pair.value as? String {
                dict[key] = value
            }
        }
    }
    
    func body(_ result: URLSessionTaskResult) -> Data {
        return result.data
    }
    
    func contentLength(_ result: URLSessionTaskResult) -> Int {
        return Int(result.urlResponse.expectedContentLength)
    }
    
    func mimeType(_ result: URLSessionTaskResult) -> NetworkingMimeType? {
        guard let rawValue = result.urlResponse.mimeType?.uppercased() else { return nil }
        return NetworkingMimeType(rawValue: rawValue)
    }
    
    func encoding(_ result: URLSessionTaskResult) -> NetworkingEncoding? {
        guard let rawValue = result.urlResponse.textEncodingName?.uppercased() else { return nil }
        return NetworkingEncoding(rawValue: rawValue)
    }
}
