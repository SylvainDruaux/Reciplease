//
//  FetchRecipesPageUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol FetchRecipesPageUseCaseProtocol {
    func execute(query: String) async throws -> RecipesPage
}

final class FetchRecipesPageUseCase: FetchRecipesPageUseCaseProtocol {
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(query: String) async throws -> RecipesPage {
        return try await recipeRepository.getRecipes(query: query)
    }
}
