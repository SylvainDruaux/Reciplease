//
//  SearchIngredientsUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 16/04/2023.
//

import Foundation

protocol SearchIngredientsUseCaseProtocol {
    func getIngredients(query: String) async throws -> IngredientResponse
}

final class SearchIngredientsUseCase: SearchIngredientsUseCaseProtocol {
    private let ingredientRepository: IngredientRepositoryProtocol
    
    init(ingredientRepository: IngredientRepositoryProtocol = IngredientRepository()) {
        self.ingredientRepository = ingredientRepository
    }
    
    func getIngredients(query: String) async throws -> IngredientResponse {
        try await ingredientRepository.getIngredients(query: query)
    }
}
