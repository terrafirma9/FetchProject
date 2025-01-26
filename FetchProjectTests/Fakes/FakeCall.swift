//
//  FakeCall.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation

final class FakeCall<T, U> {
    private let response: T
    private var error: Error? = nil
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
    
    func tryGetResponse(parameters: U) throws -> T {
        self.parameters = parameters
        callCount += 1
        if let error {
            throw error
        } else {
            return response
        }
    }
    
    func setError(_ error: Error) {
        self.error = error
    }
}
