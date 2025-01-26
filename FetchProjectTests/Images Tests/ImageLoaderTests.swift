//
//  ImageLoaderTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
import Testing
import UIKit
@testable import FetchProject

@Suite
struct ImageLoaderTests {
    @Test
    func loadingARecipeImage_whenItIsCached_returnsTheExpectedImage() async throws {
        let urlSession = FakeURLSession()
        var imageCache = FakeImageCache()
        let uiImage = try #require(UIImage(named: "tofu"))
        let imageData = uiImage.jpegData(compressionQuality: 1)
        imageCache.imageData_fake = FakeCall(with: imageData)

        let subject = ImageLoader(urlSession: urlSession, imageCache: imageCache)
        let result = try await subject.loadImage(for: .fixture(uuid: UUID()), size: .large)
        
        #expect(imageCache.imageData_fake.wasCalled == true)
        #expect(urlSession.dataFromURL_fake.wasCalled == false)
        #expect(result != nil)
    }
    
    @Test
    func loadingARecipeImage_whenDownloaded_returnsTheExpectedImage() async throws {
        var urlSession = FakeURLSession()
        let imageCache = FakeImageCache()
        let uiImage = try #require(UIImage(named: "tofu"))
        let imageData = try #require(uiImage.jpegData(compressionQuality: 1))
        urlSession.dataFromURL_fake = FakeCall(with: (imageData, .init()))

        let subject = ImageLoader(urlSession: urlSession, imageCache: imageCache)
        let result = try await subject.loadImage(for: .fixture(uuid: UUID()), size: .large)
        
        #expect(imageCache.imageData_fake.wasCalled == true)
        #expect(urlSession.dataFromURL_fake.wasCalled == true)
        #expect(result != nil)
    }
    
    @Test
    func loadingARecipeImage_whenTheUrlIsMissing_throwsAnError() async throws {
        var urlSession = FakeURLSession()
        let imageCache = FakeImageCache()
        let uiImage = try #require(UIImage(named: "tofu"))
        let imageData = try #require(uiImage.jpegData(compressionQuality: 1))
        urlSession.dataFromURL_fake = FakeCall(with: (imageData, .init()))
        
        let subject = ImageLoader(urlSession: urlSession, imageCache: imageCache)
        await #expect(throws: ImageLoadError.missingUrl) {
            let _ = try await subject.loadImage(for: .fixture(uuid: UUID(), photoUrlLarge: nil), size: .large)
        }
        
        #expect(imageCache.imageData_fake.wasCalled == true)
        #expect(urlSession.dataFromURL_fake.wasCalled == false)
    }
    
    @Test
    func loadingARecipeImage_whenTheDataIsInvalid_throwsAnError() async {
        let urlSession = FakeURLSession()
        var imageCache = FakeImageCache()
        let imageData = Data("invalid image data".utf8)
        imageCache.imageData_fake = FakeCall(with: imageData)

        let subject = ImageLoader(urlSession: urlSession, imageCache: imageCache)
        
        await #expect(throws: ImageLoadError.invalidImage) {
            let _ = try await subject.loadImage(for: .fixture(uuid: UUID()), size: .large)
        }
        
        #expect(imageCache.imageData_fake.wasCalled == true)
        #expect(urlSession.dataFromURL_fake.wasCalled == false)
    }
}
