//
//  RecipeDetailsView.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    @State private var viewModel: RecipeDetailsViewModel
    private let imageLoader: ImageLoaderProtocol
    
    init(recipe: Recipe, imageLoader: ImageLoaderProtocol) {
        _viewModel = .init(initialValue: .init(recipe: recipe))
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.hasLargeImage {
                    RecipeImageView(
                        imageLoader: imageLoader,
                        recipe: viewModel.recipe,
                        size: .large)
                    .aspectRatio(contentMode: .fill)
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.name)
                    Text(viewModel.recipe.cuisine)
                    if let sourceUrl = viewModel.recipe.sourceUrl {
                        Button("Source Recipe") {
                            UIApplication.shared.open(sourceUrl)
                        }
                    }
                    if let youtubeUrl = viewModel.recipe.youtubeUrl {
                        Button("YouTube") {
                            UIApplication.shared.open(youtubeUrl)
                        }
                    }
                }
                .padding(16)
            }
        }
        .presentationDetents([.large])
    }
}
