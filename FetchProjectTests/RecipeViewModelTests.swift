//
//  RecipeViewModelTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/26/25.
//

import Foundation
import SwiftUI
import Testing
@testable import FetchProject

@MainActor @Suite
struct RecipeViewModelTests {
    @Test
    func initilization_withDetails_setsExpectedValues() {
        let recipe = Recipe.fixture(uuid: .init())
        let subject = RecipeViewModel(recipe: recipe)
        
        #expect(subject.recipe == recipe)
        #expect(subject.cuisine == recipe.cuisine)
        #expect(subject.hasSmallImage == true)
        #expect(subject.hasDetails == true)
    }
    
    @Test
    func initilization_withoutDetails_setsExpectedValues() {
        let recipe = Recipe.fixture(uuid: .init(), photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        let subject = RecipeViewModel(recipe: recipe)
        
        #expect(subject.recipe == recipe)
        #expect(subject.cuisine == recipe.cuisine)
        #expect(subject.hasSmallImage == false)
        #expect(subject.hasDetails == false)
    }
}
