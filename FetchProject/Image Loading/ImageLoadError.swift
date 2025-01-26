//
//  ImageLoadError.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/25/25.
//

import Foundation

enum ImageLoadError: Error {
    case missingUrl
    case invalidImage
    case imageLoadInFlight
}
