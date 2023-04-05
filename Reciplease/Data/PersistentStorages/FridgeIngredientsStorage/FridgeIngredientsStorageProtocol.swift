//
//  FridgeIngredientsStorageProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol FridgeIngredientsStorageProtocol {
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients)
    func getFridgeIngredients() -> [FridgeIngredientEntity]?
}
