//
//  ImageCache.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation

protocol ImageCacheProtocol {
    func imageData(for recipe: Recipe, size: ImageSize) -> Data?
    func cacheImageData(_ image: ImageWriterProtocol, imageId: UUID, size: ImageSize)
}

struct ImageCache: ImageCacheProtocol {
    private let imageFileManager: ImageFileManagerProtocol
    
    init(imageFileManager: ImageFileManagerProtocol = FileManager.default) {
        self.imageFileManager = imageFileManager
    }
    
    func imageData(for recipe: Recipe, size: ImageSize) -> Data? {
        guard let path = imageFileManager.urlForCachedImage(imageId: recipe.id, size: size) else {
            return nil
        }
        return try? Data(contentsOf: path)
    }
    
    func cacheImageData(_ image: ImageWriterProtocol, imageId: UUID, size: ImageSize) {
        guard let path = imageFileManager.urlForCachedImage(imageId: imageId, size: size) else {
            return
        }
        try? image.write(to: path, options: [])
    }
}
