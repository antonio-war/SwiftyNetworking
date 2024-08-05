//
//  XCTest+.swift
//
//
//  Created by Antonio Guerra on 05/08/24.
//

import Foundation
import XCTest

func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line, _ errorHandler: (_ error: any Error) -> Void = { _ in }) async {
    do {
        _ = try await expression()
        let customMessage = message()
        if customMessage.isEmpty {
            XCTFail("Asynchronous call did not throw an error.", file: file, line: line)
        } else {
            XCTFail(customMessage, file: file, line: line)
        }
    } catch {
        errorHandler(error)
    }
}
