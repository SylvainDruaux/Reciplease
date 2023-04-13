//
//  RecipeRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol RecipeRepositoryProtocol {
    // MARK: - API call
    func getRecipes(query: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void)
    func getNextRecipes(url: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void)
    func getImage(url: String, completion: @escaping(Result<Data, DataError>) -> Void)
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws
//    func getFavoriteRecipes() async throws -> [Recipe]?
    func getFavoriteRecipes() async throws -> [RecipeEntity]?
    func deleteFavoriteRecipe(_ id: UUID) async throws
}
