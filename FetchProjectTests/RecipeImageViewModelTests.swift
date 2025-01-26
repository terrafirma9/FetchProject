//
//  RecipeImageViewModelTests.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/26/25.
//

import Foundation
import Testing
import UIKit
@testable import FetchProject

@MainActor @Suite
struct RecipeImageViewModelTests {
    @Test
    func initialization_setsExpectedProperties() {
        let imageLoader = FakeImageLoader()
        let recipe = Recipe.fixture(uuid: .init())
        let subject = RecipeImageViewModel(imageLoader: imageLoader, recipe: recipe, size: .large)
        
        #expect(subject.loadState == .loading)
        #expect(subject.altText == recipe.name)
    }
    
    @Test
    func loadingImage_onSuccess_updatesStateToLoaded() async {
        var imageLoader = FakeImageLoader()
        imageLoader.loadImage_fake = FakeCall(with: UIImage())
        let recipe = Recipe.fixture(uuid: .init())
        
        let subject = RecipeImageViewModel(imageLoader: imageLoader, recipe: recipe, size: .large)
        await subject.loadImage()
        
        #expect(subject.loadState == .loaded(UIImage()))
    }
    
    @Test
    func loadingImage_onFailure_leavesStateLoading() async {
        let imageLoader = FakeImageLoader()
        imageLoader.loadImage_fake.setError(FakeError.whoops)
        let recipe = Recipe.fixture(uuid: .init())
        
        let subject = RecipeImageViewModel(imageLoader: imageLoader, recipe: recipe, size: .large)
        await subject.loadImage()
        
        #expect(subject.loadState == .loading)
    }
}
