//
//  FakeRecipeService.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
@testable import FetchProject

struct FakeRecipeService: RecipeServiceProtocol {
    var fetchRecipes_fake = FakeCall<[Recipe], String>(with: [])
    func fetchRecipes(from urlString: String) async throws -> [Recipe] {
        try fetchRecipes_fake.tryGetResponse(parameters: urlString)
    }
}
