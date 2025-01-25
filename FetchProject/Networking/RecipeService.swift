//
//  RecipeService.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation

protocol RecipeServiceProtocol {
    init(urlSession: URLSessionProtocol)
    func fetchRecipes() async throws
}

struct RecipeService {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchRecipes() async throws {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw RecipeServiceError.invalidUrl
        }
        
        let (_, _) = try await urlSession.data(from: url)
    }
}
