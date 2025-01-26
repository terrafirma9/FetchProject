//
//  FakeImageCache.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
@testable import FetchProject

struct FakeImageCache: ImageCacheProtocol {
    var imageData_fake = FakeCall<Data?, (Recipe, ImageSize)>(with: nil)
    func imageData(for recipe: Recipe, size: ImageSize) -> Data? {
        imageData_fake.getResponse(parameters: (recipe, size))
    }
    
    var cacheImageData_fake = FakeCall<Void, (ImageWriterProtocol, UUID, ImageSize)>(with: ())
    func cacheImageData(_ image: ImageWriterProtocol, imageId: UUID, size: ImageSize) {
        cacheImageData_fake.getResponse(parameters: (image, imageId, size))
    }
}
