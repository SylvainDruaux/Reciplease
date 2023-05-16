//
//  RemoveFavoriteRecipesUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol RemoveFavoriteRecipesUseCaseProtocol {
    func execute(_ id: String) async throws
}

final class RemoveFavoriteRecipesUseCase: RemoveFavoriteRecipesUseCaseProtocol {
    
    private let favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol
    
    init(favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol = FavoriteRecipeRepository()) {
        self.favoriteRecipeRepository = favoriteRecipeRepository
    }
    
    func execute(_ id: String) async throws {
        try await favoriteRecipeRepository.deleteFavoriteRecipe(id)
    }
}
