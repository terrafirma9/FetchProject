//
//  RecipeImageViewModel.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI
import UIKit

@MainActor @Observable
final class RecipeImageViewModel {
    enum LoadState: Equatable {
        case loading
        case loaded(UIImage)
    }
    
    private(set) var loadState: LoadState = .loading
    private let imageLoader: ImageLoaderProtocol
    private let recipe: Recipe
    private let size: ImageSize
    var altText: String { recipe.name }
    
    init(imageLoader: ImageLoaderProtocol, recipe: Recipe, size: ImageSize) {
        self.imageLoader = imageLoader
        self.recipe = recipe
        self.size = size
    }
    
    func loadImage() async {
        do {
            let uiImage = try await imageLoader.loadImage(for: recipe, size: size)
            loadState = .loaded(uiImage)
        } catch {
            // Leave in `loading` state to retry
        }
    }
}
