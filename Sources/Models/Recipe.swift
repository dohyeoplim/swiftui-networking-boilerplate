//
//  Recipe.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation

public struct Recipe: Identifiable, Codable {
    public let id: Int
    let name: String
    let ingredients, instructions: [String]
    let prepTimeMinutes, cookTimeMinutes, servings: Int
    let difficulty, cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userID: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes, cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing, tags
        case userID = "userId"
        case image, rating, reviewCount, mealType
    }
}
