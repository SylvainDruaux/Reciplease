//
//  IngredientRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation

final class IngredientRepository: IngredientRepositoryProtocol {
    static var shared = IngredientRepository()
    
    func getIngredients(query: String, completion: @escaping(Result<IngredientResponse, DataError>) -> Void) {
        RestAPIClient.fetchData(route: .getIngredients(query: query), completion: completion)
    }
}
