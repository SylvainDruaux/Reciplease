//
//  FavoriteRecipeRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 18/04/2023.
//

import Foundation

final class FavoriteRecipeRepository: FavoriteRecipeRepositoryProtocol {
    
    private let dataSource: FavoriteRecipeDataSourceProtocol
    
    init(dataSource: FavoriteRecipeDataSourceProtocol = FavoriteRecipeDataSource()) {
        self.dataSource = dataSource
    }
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws {
        try await dataSource.create(recipe: recipe)
    }
    
    func getFavoriteRecipes() async throws -> [Recipe] {
        return try await dataSource.getAll().map { $0.toDomain() }
    }
    
    func deleteFavoriteRecipe(_ id: String) async throws {
        try await dataSource.delete(id)
    }
}
