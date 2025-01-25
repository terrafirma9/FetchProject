//
//  RecipeServiceTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation
import Testing
@testable import FetchProject

@Suite
struct RecipeServiceTests {
    @Test
    func fetchingRecipes_withValidUrl_succeeds() async throws {
        let expectedUUID = UUID()
        let expectedResponse = RecipeResponse.fixture(uuids: [expectedUUID])
        let encodedData = try JSONEncoder().encode(expectedResponse)
        
        var urlSession = FakeURLSession()
        urlSession.dataFromURL_fake = FakeCall(with: (encodedData, .init()))
        
        let urlString = "https://www.fetch.com/valid/recipe/url"
        let subject = RecipeService(urlSession: urlSession)
        let recipes = try await subject.fetchRecipes(from: urlString)
        let expectedURL = try #require(URL(string: urlString))
        
        #expect(urlSession.dataFromURL_fake.wasCalled == true)
        #expect(urlSession.dataFromURL_fake.parameters == expectedURL)
        #expect(recipes == expectedResponse.recipes)
    }
    
    @Test
    func fetchingRecipes_withInvalidUrl_throwsAnError() async throws {
        let urlSession = FakeURLSession()
        let urlString = ""
        let subject = RecipeService(urlSession: urlSession)
        
        await #expect(throws: RecipeServiceError.invalidUrl) {
            let _ = try await subject.fetchRecipes(from: urlString)
        }
        
        #expect(urlSession.dataFromURL_fake.wasCalled == false)
    }
    
    @Test
    func fetchingRecipes_withInvalidJson_throwsAnError() async throws {
        let urlSession = FakeURLSession()
        let urlString = "https://www.fetch.com/valid/recipe/url"
        let subject = RecipeService(urlSession: urlSession)
        
        await #expect(throws: RecipeServiceError.failedToFetchRecipes) {
            let _ = try await subject.fetchRecipes(from: urlString)
        }
        
        #expect(urlSession.dataFromURL_fake.wasCalled == true)
    }
}

private extension Recipe {
    static func fixture(uuid: UUID) -> Self {
        .init(
            cuisine: "Antarctic",
            name: "Ice Pudding",
            uuid: uuid,
            photoUrlLarge: URL(string: "https://www.fetch.com/photo/large"),
            photoUrlSmall: URL(string: "https://www.fetch.com/photo/small"),
            sourceUrl: URL(string: "https://www.fetch.com/source/url"),
            youtubeUrl: URL(string: "https://www.fetch.com/youtubeUrl"))
    }
}

private extension RecipeResponse {
    static func fixture(uuids: [UUID]) -> Self {
        .init(recipes: uuids.map { .fixture(uuid: $0) })
    }
}
