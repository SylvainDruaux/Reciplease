//
//  RecipeEntity+Mapping.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 14/04/2023.
//

import Foundation
import CoreData

extension RecipeEntity {
    func toDomain() -> Recipe {
        return .init(label: label ?? "",
                     imageUrl: imageUrl ?? "",
                     sourceUrl: sourceUrl ?? "",
                     yield: yield,
                     ingredientLines: ingredientLines ?? [""],
                     ingredients: ingredients ?? [""],
                     totalTime: totalTime
        )
    }
    
    convenience init(recipe: Recipe, in context: NSManagedObjectContext) {
        self.init(context: context)
        id = recipe.id
        imageUrl = recipe.imageUrl
        ingredientLines = recipe.ingredientLines
        ingredients = recipe.ingredients
        label = recipe.label
        sourceUrl = recipe.sourceUrl
        totalTime = recipe.totalTime
        yield = recipe.yield
    }
}
