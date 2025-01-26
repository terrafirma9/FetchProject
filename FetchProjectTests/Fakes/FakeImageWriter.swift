//
//  FakeImageWriter.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/26/25.
//

import Foundation
@testable import FetchProject

struct FakeImageWriter: ImageWriterProtocol {
    var write_fake = FakeCall<Void, (URL, Data.WritingOptions)>(with: ())
    func write(to url: URL, options: Data.WritingOptions) throws {
        try write_fake.tryGetResponse(parameters: (url, options))
    }
}
