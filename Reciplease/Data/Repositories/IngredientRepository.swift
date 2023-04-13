//
//  IngredientRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation

final class IngredientRepository: IngredientRepositoryProtocol {
    
    private let restAPIClient: RestAPIClientProtocol
    
    init(restAPIClient: RestAPIClientProtocol = RestAPIClient()) {
        self.restAPIClient = restAPIClient
    }
    
    func getIngredients(query: String, completion: @escaping(Result<IngredientResponse, DataError>) -> Void) {
        restAPIClient.fetchData(route: .getIngredients(query: query), completion: completion)
    }
}
