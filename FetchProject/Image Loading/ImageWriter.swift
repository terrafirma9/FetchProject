//
//  ImageWriter.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/26/25.
//

import Foundation

protocol ImageWriterProtocol {
    func write(to url: URL, options: Data.WritingOptions) throws
}

extension Data: ImageWriterProtocol {}
