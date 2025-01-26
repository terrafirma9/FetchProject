//
//  ImageLoader.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import Combine
import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(for recipe: Recipe, size: ImageSize) async throws -> UIImage
}

final class ImageLoader: ImageLoaderProtocol {
    struct Request: Hashable {
        let uuid: UUID
        let size: ImageSize
    }
    
    private let urlSession: URLSessionProtocol
    private let imageCache: ImageCacheProtocol
    private var inFlightRequests: Set<Request> = []
    
    init(urlSession: URLSessionProtocol = URLSession.ephemeral,
         imageCache: ImageCacheProtocol = ImageCache()) {
        self.urlSession = urlSession
        self.imageCache = imageCache
    }
    
    @MainActor
    func loadImage(for recipe: Recipe, size: ImageSize) async throws -> UIImage {
        let request = Request(uuid: recipe.id, size: size)
        
        guard !inFlightRequests.contains(request) else {
            throw ImageLoadError.imageLoadInFlight
        }
        
        inFlightRequests.insert(request)
        
        defer {
            inFlightRequests.remove(request)
        }
        
        var data: Data
                
        if let cachedData = imageCache.imageData(for: recipe, size: size) {
            data = cachedData
        } else {
            let imageUrl = switch size {
            case .large: recipe.photoUrlLarge
            case .small: recipe.photoUrlSmall
            }
            
            guard let imageUrl else {
                throw ImageLoadError.missingUrl
            }
            
            let (imageData, _) = try await urlSession.data(from: imageUrl)
            
            data = imageData
            imageCache.cacheImageData(imageData, imageId: recipe.id, size: size)
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageLoadError.invalidImage
        }
        
        return image
    }
}
