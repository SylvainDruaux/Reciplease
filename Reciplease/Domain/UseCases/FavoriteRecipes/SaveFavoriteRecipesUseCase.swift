//
//  SaveFavoriteRecipesUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol SaveFavoriteRecipesUseCaseProtocol {
    func execute(_ recipe: Recipe) async throws
}

final class SaveFavoriteRecipesUseCase: SaveFavoriteRecipesUseCaseProtocol {
    
    private let favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol
    
    init(favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol = FavoriteRecipeRepository()) {
        self.favoriteRecipeRepository = favoriteRecipeRepository
    }
    
    func execute(_ recipe: Recipe) async throws {
        try await favoriteRecipeRepository.createFavoriteRecipe(recipe)
    }
}
