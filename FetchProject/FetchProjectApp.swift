//
//  FetchProjectApp.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

@main
struct FetchProjectApp: App {
    @State private var hasFlushedCache: Bool = false
    
    var body: some Scene {
        WindowGroup {
            RecipesListView()
                .onAppear {
                    emptyCacheOnLaunch()
                }
        }
    }
    
    /// So we don't have cached images on subsequent launches, just for this project
    private func emptyCacheOnLaunch() {
        guard !hasFlushedCache,
              let cachesDirectory = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask).first
        else {
            return
        }
        try? FileManager.default.contentsOfDirectory(
            at: cachesDirectory,
            includingPropertiesForKeys: nil).forEach {
                try? FileManager.default.removeItem(at: $0)
        }
        hasFlushedCache = true
    }
}

extension EnvironmentValues {
    @Entry var imageLoader: ImageLoader = .init()
}
