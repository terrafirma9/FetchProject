//
//  RecipeViewModel.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import SwiftUI

@MainActor @Observable
final class RecipeViewModel {
    let hasSmallImage: Bool
    let hasDetails: Bool
    let recipe: Recipe
    let name: LocalizedStringKey
    let cuisine: String
    
    init(recipe: Recipe) {
        self.hasSmallImage = recipe.photoUrlSmall != nil
        self.hasDetails = recipe.photoUrlLarge != nil || recipe.sourceUrl != nil || recipe.youtubeUrl != nil
        self.recipe = recipe
        self.name = "**\(recipe.name)**"
        self.cuisine = recipe.cuisine
    }
}
