//
//  FetchFavoriteRecipesUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol FetchFavoriteRecipesUseCaseProtocol {
    func execute() async throws -> [Recipe]
}

final class FetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseProtocol {
    
    private let favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol
    
    init(favoriteRecipeRepository: FavoriteRecipeRepositoryProtocol = FavoriteRecipeRepository()) {
        self.favoriteRecipeRepository = favoriteRecipeRepository
    }
    
    func execute() async throws -> [Recipe] {
        return try await favoriteRecipeRepository.getFavoriteRecipes()
    }
}
