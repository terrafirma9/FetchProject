//
//  RecipeDetailsViewModel.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import SwiftUI

@MainActor
final class RecipeDetailsViewModel {
    let recipe: Recipe
    let name: LocalizedStringKey
    let hasLargeImage: Bool
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.name = "**\(recipe.name)**"
        self.hasLargeImage = recipe.photoUrlLarge != nil
    }
}
