//
//  RemoveFridgeIngredientsUseCase.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 16/04/2023.
//

import Foundation

protocol RemoveFridgeIngredientsUseCaseProtocol {
    func execute() async throws
}

final class RemoveFridgeIngredientsUseCase: RemoveFridgeIngredientsUseCaseProtocol {
    
    private let fridgeIngredientRepository: FridgeIngredientRepositoryProtocol
    
    init(fridgeIngredientRepository: FridgeIngredientRepositoryProtocol = FridgeIngredientRepository()) {
        self.fridgeIngredientRepository = fridgeIngredientRepository
    }
    
    func execute() async throws {
        try await fridgeIngredientRepository.deleteFridgeIngredients()
    }
}
