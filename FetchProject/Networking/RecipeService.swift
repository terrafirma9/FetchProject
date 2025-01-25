//
//  RecipeService.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation

protocol RecipeServiceProtocol {
    init(urlSession: URLSessionProtocol)
    func fetchRecipes() async throws -> [Recipe]
}

struct RecipeService {
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
            let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return response.recipes
        } catch {
            throw RecipeServiceError.failedToFetchRecipes
        }
    }
}
