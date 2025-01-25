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
        .task { try! await RecipeService().fetchRecipes() }
    }
}

#Preview {
    ContentView()
}
