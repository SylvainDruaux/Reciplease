//
//  FetchNextRecipesPageUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol FetchNextRecipesPageUseCaseProtocol {
    func execute(url: String) async throws -> RecipesPage
}

final class FetchNextRecipesPageUseCase: FetchNextRecipesPageUseCaseProtocol {
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(url: String) async throws -> RecipesPage {
        return try await recipeRepository.getNextRecipes(url: url)
    }
}
