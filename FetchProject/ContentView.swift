//
//  ContentView.swift
//  FetchProject
//
//  Created by Matthew Callahan on 1/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            let recipes = try! await RecipeService().fetchRecipes(from: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
            print(recipes)
        }
    }
}

#Preview {
    ContentView()
}
