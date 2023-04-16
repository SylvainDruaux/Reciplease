//
//  RecipeRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol RecipeRepositoryProtocol {
    // MARK: - API call
    func getRecipes(query: String) async throws -> RecipeResponseDTO
    func getNextRecipes(url: String) async throws -> RecipeResponseDTO
    func getImage(url: String) async throws -> Data
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws
    func getFavoriteRecipes() async throws -> [RecipeEntity]
    func deleteFavoriteRecipe(_ id: UUID) async throws
}
