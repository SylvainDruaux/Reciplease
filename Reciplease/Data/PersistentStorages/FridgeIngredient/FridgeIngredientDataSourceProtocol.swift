//
//  FridgeIngredientDataSourceProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation

protocol FridgeIngredientDataSourceProtocol {
    func save(fridgeIngredients: FridgeIngredients) async throws
    func getAll() async throws -> FridgeIngredients
    func deleteAll() async throws
}
