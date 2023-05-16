//
//  FavoriteRecipeRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 18/04/2023.
//

import Foundation

protocol FavoriteRecipeRepositoryProtocol {
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws
    func getFavoriteRecipes() async throws -> [Recipe]
    func deleteFavoriteRecipe(_ id: String) async throws
}
