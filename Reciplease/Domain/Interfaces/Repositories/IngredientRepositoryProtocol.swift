//
//  IngredientRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol IngredientRepositoryProtocol {
    func getIngredients(query: String, completion: @escaping(Result<IngredientResponse, DataError>) -> Void)
}
