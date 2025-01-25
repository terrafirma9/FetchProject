//
//  FakeURLSession.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation
@testable import FetchProject

struct FakeURLSession: URLSessionProtocol {
    var dataFromURL_fake = FakeCall<(Data, URLResponse), URL>(with: (.init(), .init()))
    func data(from url: URL) async throws -> (Data, URLResponse) {
        dataFromURL_fake.getResponse(parameters: url)
    }
}

final class FakeCall<T, U> {
    private let response: T
    private(set) var parameters: U? = nil
    private(set) var callCount: Int = 0
    var wasCalled: Bool { callCount > 0 }
    
    init(with response: T) {
        self.response = response
    }
    
    func getResponse(parameters: U) -> T {
        self.parameters = parameters
        callCount += 1
        return response
    }
}
