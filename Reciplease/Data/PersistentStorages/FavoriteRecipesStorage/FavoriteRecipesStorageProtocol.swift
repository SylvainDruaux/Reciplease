//
//  FavoriteRecipesStorageProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol FavoriteRecipesStorageProtocol {
    func saveRecipe(_ recipe: Recipe)
    func getFavoriteRecipes() -> [RecipeEntity]?
    func checkDuplicate(for recipe: Recipe) -> Bool
}
