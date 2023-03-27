//
//  FridgeIngredientModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 24/03/2023.
//

import Foundation

struct FridgeIngredientModel: Equatable, Identifiable {
    typealias Identifier = UUID
    
    let id: Identifier
    let name: String?
}
