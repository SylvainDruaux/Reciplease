//
//  FetchFridgeIngredientsUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol FetchFridgeIngredientsUseCaseProtocol {
    func execute() async throws -> FridgeIngredients
}

final class FetchFridgeIngredientsUseCase: FetchFridgeIngredientsUseCaseProtocol {
    
    private let fridgeIngredientRepository: FridgeIngredientRepositoryProtocol
    
    init(fridgeIngredientRepository: FridgeIngredientRepositoryProtocol = FridgeIngredientRepository()) {
        self.fridgeIngredientRepository = fridgeIngredientRepository
    }
    
    func execute() async throws -> FridgeIngredients {
        return try await fridgeIngredientRepository.getFridgeIngredients()
    }
}
