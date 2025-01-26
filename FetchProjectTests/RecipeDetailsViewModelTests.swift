//
//  RecipeDetailsViewModelTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/26/25.
//

import Foundation
import Testing
@testable import FetchProject

@MainActor @Suite
struct RecipeDetailsViewModelTests {
    @Test(arguments: [URL(string: "https://www.fetch.com"), nil])
    func initialization_setsExpectedValues(largeUrl: URL?) {
        let recipe = Recipe.fixture(uuid: .init(), photoUrlLarge: largeUrl)
        let subject = RecipeDetailsViewModel(recipe: recipe)
        
        #expect(subject.recipe == recipe)
        #expect(subject.hasLargeImage == (largeUrl != nil))
    }
}
