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
    func fetchingRecipes_succeeds() async throws {
        let urlSession = FakeURLSession()
        let subject = RecipeService(urlSession: urlSession)
        
        try await subject.fetchRecipes()
        let expectedURL = try #require(URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"))
        
        #expect(urlSession.dataFromURL_fake.wasCalled)
        #expect(urlSession.dataFromURL_fake.parameters == expectedURL)
    }
}
