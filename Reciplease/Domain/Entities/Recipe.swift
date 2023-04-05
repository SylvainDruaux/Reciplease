//
//  Recipe.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/04/2023.
//

import Foundation

struct Recipe {
    let label: String
    let imageUrl: String
    let sourceUrl: String
    let yield: Float
    let ingredientLines: [String]
    let ingredients: [String]
    let totalTime: Double
}

struct RecipesPage {
    let nextPage: String?
    var recipes: [Recipe]
}
