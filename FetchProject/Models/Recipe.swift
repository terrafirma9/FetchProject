//
//  Recipe.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import Foundation

struct RecipeResponse: Codable, Equatable, Sendable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Equatable, Sendable {
    let cuisine: String
    let name: String
    let uuid: UUID
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?
}
