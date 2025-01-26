//
//  ImageCacheTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
import Testing
@testable import FetchProject

@Suite
struct ImageCacheTests {
    @Test
    func requestingImageData_whenCached_returnsData() throws {
        var imageFileManager = FakeImageFileManager()
        let validUrl = try #require(Bundle.main.url(forResource: "bundle_tofu", withExtension: "jpg"))
        imageFileManager.urlForCachedImage_fake = FakeCall(with: validUrl)
        let expectedData = try Data(contentsOf: validUrl)
        
        let subject = ImageCache(imageFileManager: imageFileManager)
        let imageId = UUID()
        let recipe = Recipe.fixture(uuid: imageId)
        
        let cachedData = subject.imageData(for: recipe, size: .small)
        
        #expect(imageFileManager.urlForCachedImage_fake.wasCalled)
        #expect(expectedData == cachedData)
    }
    
    @Test
    func cachingImageData_writesItToDisk() throws {
        var imageFileManager = FakeImageFileManager()
        let validUrl = try #require(Bundle.main.url(forResource: "bundle_tofu", withExtension: "jpg"))
        imageFileManager.urlForCachedImage_fake = FakeCall(with: validUrl)
        
        let subject = ImageCache(imageFileManager: imageFileManager)
        let imageWriter = FakeImageWriter()
        
        subject.cacheImageData(imageWriter, imageId: UUID(), size: .small)
        
        #expect(imageWriter.write_fake.wasCalled == true)
        let parameters = try #require(imageWriter.write_fake.parameters)
        #expect(parameters == (validUrl, []))
    }
}
