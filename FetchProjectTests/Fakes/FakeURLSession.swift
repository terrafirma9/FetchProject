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
