//
//  RecipesRepository.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation

public struct RecipesRepository {
    private let client: APIClient
    private let baseURL = URL(string: "https://dummyjson.com/recipes")!

    public init(client: APIClient = NetworkClient.shared) {
        self.client = client
    }

    public func fetchPage(limit: Int, skip: Int) async throws -> PaginatedResponse<Recipe> {
        let req = APIRequest(
            baseURL: baseURL,
            queryItems: [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)")
            ],
            cachePolicy: .returnCacheDataElseLoad
        )
        return try await client.send(req)
    }
}
