//
//  RecipesViewModel.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

@MainActor @Observable
final class RecipesListViewModel {
    enum LoadState: Equatable {
        case loading
        case loaded([Recipe])
        case error
    }
    
    private(set) var loadState: LoadState = .loading
    
    private let service: RecipeServiceProtocol
    private let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
    
    func fetchRecipes() async {
        do {
            let recipes = try await service.fetchRecipes(from: urlString)
            loadState = .loaded(recipes)
        } catch {
            loadState = .error
        }
    }
    
    func reloadRecipes() {
        loadState = .loading
    }
}
