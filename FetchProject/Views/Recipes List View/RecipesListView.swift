//
//  ContentView.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

struct RecipesListView: View {
    @Environment(\.imageLoader) private var imageLoader
    @State private var viewModel: RecipesListViewModel = .init()
    @State private var recipeToPresent: Recipe? = nil
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.reloadRecipes()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.loadState {
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .task { await viewModel.fetchRecipes() }
        case .loaded(let recipes):
            if recipes.isEmpty {
                VStack(alignment: .center, spacing: 16) {
                    Image(systemName: "questionmark.folder")
                    Text("We didn't find any recipes!")
                }
            } else {
                recipesView(recipes: recipes)
            }
        case .error:
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                Text("Looks like there's an error!")
            }
        }
    }
    
    private func recipesView(recipes: [Recipe]) -> some View {
        List {
            ForEach(recipes) {
                RecipeView(recipe: $0, imageLoader: imageLoader) { recipe in
                    recipeToPresent = recipe
                }
            }
        }
        .listStyle(.plain)
        .sheet(item: $recipeToPresent) { recipe in
            RecipeDetailsView(
                recipe: recipe,
                imageLoader: imageLoader)
        }
    }
}

#Preview {
    RecipesListView()
}
