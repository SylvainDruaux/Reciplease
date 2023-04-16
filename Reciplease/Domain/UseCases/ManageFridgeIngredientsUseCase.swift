//
//  ManageFridgeIngredientsUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 16/04/2023.
//

import Foundation

protocol ManageFridgeIngredientsUseCaseProtocol {
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) async throws
    func getFridgeIngredients() async throws -> FridgeIngredients
    func deleteFridgeIngredients() async throws
}

final class ManageFridgeIngredientsUseCase: ManageFridgeIngredientsUseCaseProtocol {
    
    private let fridgeIngredientRepository: FridgeIngredientRepositoryProtocol
    
    init(fridgeIngredientRepository: FridgeIngredientRepositoryProtocol = FridgeIngredientRepository()) {
        self.fridgeIngredientRepository = fridgeIngredientRepository
    }
    
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) async throws {
        return try await fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredients)
    }
    
    func getFridgeIngredients() async throws -> FridgeIngredients {
        return try await fridgeIngredientRepository.getFridgeIngredients()
    }
    
    func deleteFridgeIngredients() async throws {
        return try await fridgeIngredientRepository.deleteFridgeIngredients()
    }
}
