//
//  ManageFavoriteRecipesUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol ManageFavoriteRecipesUseCaseProtocol {
    func createFavoriteRecipe(_ recipe: Recipe) async throws
    func getFavoriteRecipes() async throws -> [RecipeEntity]
    func deleteFavoriteRecipe(_ id: UUID) async throws
}

final class ManageFavoriteRecipesUseCase: ManageFavoriteRecipesUseCaseProtocol {
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func createFavoriteRecipe(_ recipe: Recipe) async throws {
        return try await recipeRepository.createFavoriteRecipe(recipe)
    }
    
    func getFavoriteRecipes() async throws -> [RecipeEntity] {
        return try await recipeRepository.getFavoriteRecipes()
    }
    
    func deleteFavoriteRecipe(_ id: UUID) async throws {
        return try await recipeRepository.deleteFavoriteRecipe(id)
    }
}
