//
//  RecipeViewModel.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation
import Observation

@MainActor
@Observable
public final class RecipesViewModel {
    public var recipes: [Recipe] = []
    public var searchQuery: String = ""
    public var isLoading: Bool = false
    public var errorMessage: String?

    private let repository: RecipesRepository
    private var skip = 0
    private let pageSize = 20
    private var total = Int.max

    public init(repository: RecipesRepository = .init()) {
        self.repository = repository
    }

    public var filtered: [Recipe] {
        guard !searchQuery.isEmpty else { return recipes }
        return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
    }

    public func loadMoreIfNeeded(current: Recipe) async {
        guard
            current.id == recipes.last?.id,
            recipes.count < total,
            !isLoading
        else { return }
        await loadNextPage()
    }

    public func reload() async {
        recipes.removeAll()
        skip = 0
        total = Int.max
        await loadNextPage()
    }

    private func loadNextPage() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let page = try await repository.fetchPage(limit: pageSize, skip: skip)
            recipes.append(contentsOf: page.items)
            skip += page.limit
            total = page.total
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
