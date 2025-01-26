//
//  Fixtures.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
@testable import FetchProject

extension Recipe {
    static func fixture(
        uuid: UUID,
        photoUrlLarge: URL? = URL(string: "https://www.fetch.com/photo/large"),
        photoUrlSmall: URL? = URL(string: "https://www.fetch.com/photo/small"),
        sourceUrl: URL? = URL(string: "https://www.fetch.com/source/url"),
        youtubeUrl: URL? = URL(string: "https://www.fetch.com/youtubeUrl")) -> Self {
            .init(
                cuisine: "Antarctic",
                name: "Ice Pudding",
                uuid: uuid,
                photoUrlLarge: photoUrlLarge,
                photoUrlSmall: photoUrlSmall,
                sourceUrl: sourceUrl,
                youtubeUrl: youtubeUrl)
    }
}

extension RecipeResponse {
    static func fixture(uuids: [UUID]) -> Self {
        .init(recipes: uuids.map { .fixture(uuid: $0) })
    }
}
