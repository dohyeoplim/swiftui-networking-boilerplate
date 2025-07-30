//
//  RecipesListView.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import SwiftUI

public struct RecipesListView: View {
    @State private var vm = RecipesViewModel()

    public var body: some View {
        NavigationStack {
            List {
                ForEach(vm.filtered) { recipe in
                    RecipeRowView(recipe: recipe)
                        .onAppear { Task { await vm.loadMoreIfNeeded(current: recipe) } }
                }
                if vm.isLoading {
                    SkeletonRowView()
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Recipes")
            .searchable(text: $vm.searchQuery)
            .refreshable { await vm.reload() }
            .alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
                Button("OK") { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "Unknown Error")
            }
            .task { await vm.reload() }
        }
    }
}

#Preview {
    RecipesListView()
}
