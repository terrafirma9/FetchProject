//
//  RecipeView.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

struct RecipeView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State private var viewModel: RecipeViewModel
    private let imageLoader: ImageLoaderProtocol
    
    let onPresentDetails: (Recipe) -> Void
    
    init(recipe: Recipe,
         imageLoader: ImageLoaderProtocol,
         onPresentDetails: @escaping (Recipe) -> Void) {
        _viewModel = .init(initialValue: .init(recipe: recipe))
        self.imageLoader = imageLoader
        self.onPresentDetails = onPresentDetails
    }
    
    var body: some View {
        if dynamicTypeSize >= .accessibility1 {
            largeContent
        } else {
            content
        }
    }
    
    var content: some View {
        HStack(alignment: .top, spacing: 16) {
            if viewModel.hasSmallImage {
                RecipeImageView(
                    imageLoader: imageLoader,
                    recipe: viewModel.recipe,
                    size: .small)
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                Text(viewModel.cuisine)
                if viewModel.hasDetails {
                    Button("Show details") {
                        onPresentDetails(viewModel.recipe)
                    }
                    .foregroundStyle(Color.cyan)
                }
            }
        }
    }
    
    var largeContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.hasSmallImage {
                RecipeImageView(
                    imageLoader: imageLoader,
                    recipe: viewModel.recipe,
                    size: .small)
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                    .fixedSize(horizontal: false, vertical: true)
                Text(viewModel.cuisine)
                if viewModel.hasDetails {
                    Button("Show details") {
                        onPresentDetails(viewModel.recipe)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
