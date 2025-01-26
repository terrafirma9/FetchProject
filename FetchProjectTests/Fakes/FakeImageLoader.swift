//
//  FakeImageLoader.swift
//  FetchProjectTests
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation
import UIKit
@testable import FetchProject

struct FakeImageLoader: ImageLoaderProtocol {
    var loadImage_fake = FakeCall<UIImage, (Recipe, ImageSize)>(with: UIImage())
    func loadImage(for recipe: Recipe, size: ImageSize) async throws -> UIImage {
        try loadImage_fake.tryGetResponse(parameters: (recipe, size))
    }
}
