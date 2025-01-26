//
//  FakeImageFileManager.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
@testable import FetchProject

struct FakeImageFileManager: ImageFileManagerProtocol {
    var urlForCachedImage_fake = FakeCall<URL?, (UUID, ImageSize)>(with: nil)
    func urlForCachedImage(imageId: UUID, size: ImageSize) -> URL? {
        urlForCachedImage_fake.getResponse(parameters: (imageId, size))
    }
}
