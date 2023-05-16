//
//  FetchRecipeImageUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol FetchRecipeImageUseCaseProtocol {
    func execute(url: String) async throws -> Data
}

final class FetchRecipeImageUseCase: FetchRecipeImageUseCaseProtocol {
    
    private let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(url: String) async throws -> Data {
        return try await recipeRepository.getImage(url: url)
    }
}
