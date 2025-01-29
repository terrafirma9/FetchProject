//
//  RecipesListViewModelTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
import Testing
@testable import FetchProject

@MainActor @Suite
struct RecipesListViewModelTests {
    @Test
    func fetchingRecipes_whenRecipesAreAvailable_setsTheLoadState() async {
        let recipes = RecipeResponse.fixture(uuids: [UUID(), UUID(), UUID()]).recipes
        var service = FakeRecipeService()
        service.fetchRecipes_fake = FakeCall(with: recipes)
        let subject = RecipesListViewModel(service: service)
        #expect(subject.loadState == .loading)
        
        await subject.fetchRecipes()
        #expect(subject.loadState == .loaded(recipes))
    }
    
    @Test
    func fetchingRecipes_whenThereIsAnError_showsTheErrorState() async {
        let service = FakeRecipeService()
        service.fetchRecipes_fake.setError(FakeError.whoops)
        let subject = RecipesListViewModel(service: service)
        #expect(subject.loadState == .loading)
        
        await subject.fetchRecipes()
        #expect(service.fetchRecipes_fake.wasCalled)
        #expect(service.fetchRecipes_fake.parameters == "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        #expect(subject.loadState == .error)
    }
    
    @Test
    func reloadingRecipes_setsTheLoadingState() async {
        let service = FakeRecipeService()
        let subject = RecipesListViewModel(service: service)
        #expect(subject.loadState == .loading)
        
        await subject.fetchRecipes()
        #expect(subject.loadState == .loaded([]))
        
        subject.reloadRecipes()
        #expect(subject.loadState == .loading)
    }
}
