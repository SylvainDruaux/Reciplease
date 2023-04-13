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
        do {
            try await dataSource.save(fridgeIngredients: fridgeIngredients)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFridgeIngredients() async throws -> FridgeIngredients? {
        do {
            return try await dataSource.getAll()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteFridgeIngredients() async throws {
        do {
            try await dataSource.deleteAll()
        } catch {
            print(error.localizedDescription)
        }
    }
}
