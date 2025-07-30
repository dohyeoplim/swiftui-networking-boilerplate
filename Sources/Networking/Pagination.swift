//
//  Pagination.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation

public struct PaginatedResponse<T: Decodable>: Decodable {
    public let items: [T]
    public let total: Int
    public let skip: Int
    public let limit: Int

    enum CodingKeys: String, CodingKey {
        case items = "recipes"
        case total, skip, limit
    }
}
