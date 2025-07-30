//
//  RecipeRowView.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import SwiftUI
import Kingfisher

public struct RecipeRowView: View {
    public let recipe: Recipe

    public var body: some View {
        HStack(spacing: 12) {
//            AsyncImage(url: URL(string: recipe.image)) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                        .frame(width: 50, height: 50)
//                case .success(let img):
//                    img.resizable()
//                       .scaledToFill()
//                       .frame(width: 50, height: 50)
//                       .clipShape(RoundedRectangle(cornerRadius: 8))
//                case .failure:
//                    Image(systemName: "photo")
//                        .frame(width: 50, height: 50)
//                        .foregroundStyle(.secondary)
//                @unknown default: EmptyView()
//                }
//            }
            KFImage(URL(string: recipe.image))
                .placeholder { ProgressView() }
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 50, height: 50)))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text("🕒 \(recipe.cookTimeMinutes) min")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    let mockRecipe = Recipe(
        id: 1,
        name: "Classic Margherita Pizza",
        ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
        ],
        instructions: [
            "Preheat the oven to 475°F (245°C).",
            "Roll out the pizza dough and spread tomato sauce evenly.",
            "Top with slices of fresh mozzarella and fresh basil leaves.",
            "Drizzle with olive oil and season with salt and pepper.",
            "Bake in the preheated oven for 12–15 minutes or until the crust is golden brown.",
            "Slice and serve hot."
        ],
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
        servings: 4,
        difficulty: "Easy",
        cuisine: "Italian",
        caloriesPerServing: 300,
        tags: ["Pizza", "Italian"],
        userID: 45,
        image: "https://cdn.dummyjson.com/recipe-images/1.webp",
        rating: 4.6,
        reviewCount: 3,
        mealType: ["Dinner"]
    )
    
    RecipeRowView(recipe: mockRecipe)
}
