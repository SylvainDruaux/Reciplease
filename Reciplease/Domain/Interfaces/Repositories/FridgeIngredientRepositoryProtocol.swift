//
//  FridgeIngredientRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation

protocol FridgeIngredientRepositoryProtocol {
    // MARK: - Persistent Storage
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) async throws
    func getFridgeIngredients() async throws -> FridgeIngredients
    func deleteFridgeIngredients() async throws
}
