//
//  RecipeService.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(from urlString: String) async throws -> [Recipe]
}

struct RecipeService: RecipeServiceProtocol {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchRecipes(from urlString: String) async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw RecipeServiceError.invalidUrl
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(RecipeResponse.self, from: data)
            return response.recipes
        } catch {
            throw RecipeServiceError.failedToFetchRecipes
        }
    }
}
