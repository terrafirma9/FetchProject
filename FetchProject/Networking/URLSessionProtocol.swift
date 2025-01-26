//
//  URLSessionProtocol.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    static let ephemeral: URLSession = URLSession(configuration: .ephemeral)
}
