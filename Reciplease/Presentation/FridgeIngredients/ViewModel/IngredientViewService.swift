//
//  IngredientViewService.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation

class IngredientViewService {
    static var shared = IngredientViewService()
    
    // API call only (No persistent storage required)
    func getIngredients(query: String, completion: @escaping(Result<IngredientResponse, DataError>) -> Void) {
        RestAPIClient.fetchData(route: .getIngredients(query: query), completion: completion)
    }
}
