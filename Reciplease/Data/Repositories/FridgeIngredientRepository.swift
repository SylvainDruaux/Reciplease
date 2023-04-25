//
//  FridgeIngredientRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation

final class FridgeIngredientRepository: FridgeIngredientRepositoryProtocol {
    private let dataSource: FridgeIngredientDataSourceProtocol
    
    init(dataSource: FridgeIngredientDataSourceProtocol = FridgeIngredientDataSource()) {
        self.dataSource = dataSource
    }
    
    // MARK: - Persistent Storage
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) async throws {
        try await dataSource.save(fridgeIngredients: fridgeIngredients)
    }
    
    func getFridgeIngredients() async throws -> FridgeIngredients {
        return try await dataSource.getAll()
    }
    
    func deleteFridgeIngredients() async throws {
        try await dataSource.deleteAll()
    }
}
