//
//  RecipeImageView.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

struct RecipeImageView: View {
    @State private var viewModel: RecipeImageViewModel
    
    init(imageLoader: ImageLoaderProtocol,
         recipe: Recipe,
         size: ImageSize) {
        _viewModel = .init(initialValue: .init(
            imageLoader: imageLoader,
            recipe: recipe,
            size: size))
    }
    
    var body: some View {
        switch viewModel.loadState {
        case .loading:
            Color.lightGray
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 88)
                .overlay {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .task {
                    await viewModel.loadImage()
                }
        case .loaded(let image):
            Image(uiImage: image)
                .resizable()
                .accessibilityLabel(viewModel.altText)
        }
    }
}

private extension Color {
    static let lightGray: Color = Color(hue: 0, saturation: 0, brightness: 0.8)
}
