//
//  SaveFridgeIngredientsUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

protocol SaveFridgeIngredientsUseCaseProtocol {
    func execute(_ fridgeIngredients: FridgeIngredients) async throws
}

final class SaveFridgeIngredientsUseCase: SaveFridgeIngredientsUseCaseProtocol {
    
    private let fridgeIngredientRepository: FridgeIngredientRepositoryProtocol
    
    init(fridgeIngredientRepository: FridgeIngredientRepositoryProtocol = FridgeIngredientRepository()) {
        self.fridgeIngredientRepository = fridgeIngredientRepository
    }
    
    func execute(_ fridgeIngredients: FridgeIngredients) async throws {
        try await fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredients)
    }
}
