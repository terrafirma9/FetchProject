//
//  FileManager.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation

protocol ImageFileManagerProtocol {
    func urlForCachedImage(imageId: UUID, size: ImageSize) -> URL?
}

extension FileManager: ImageFileManagerProtocol {
    func urlForCachedImage(imageId: UUID, size: ImageSize) -> URL? {
        let sizeDirectory = switch size {
        case .large: "large"
        case .small: "small"
        }
        
        let component = "\(imageId)\(sizeDirectory)image.jpg"
        
        return urls(for: .cachesDirectory, in: .userDomainMask).first.map {
            $0.appendingPathComponent(component)
        }
    }
}
