//
//  SearchRecipesUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol SearchRecipesUseCaseProtocol {
    func getRecipes(query: String) async throws -> RecipeResponseDTO
    func getNextRecipes(url: String) async throws -> RecipeResponseDTO
    func getImage(url: String) async throws -> Data
}

final class SearchRecipesUseCase: SearchRecipesUseCaseProtocol {
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func getRecipes(query: String) async throws -> RecipeResponseDTO {
        return try await recipeRepository.getRecipes(query: query)
    }
    
    func getNextRecipes(url: String) async throws -> RecipeResponseDTO {
        return try await recipeRepository.getNextRecipes(url: url)
    }
    
    func getImage(url: String) async throws -> Data {
        return try await recipeRepository.getImage(url: url)
    }
}
