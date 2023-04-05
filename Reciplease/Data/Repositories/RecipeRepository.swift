//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

final class RecipeRepository: RecipeRepositoryProtocol {
    static var shared = RecipeRepository()
    
    func getRecipes(query: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void) {
        RestAPIClient.fetchData(route: .getRecipes(query: query), completion: completion)
    }
    
    func getImage(url: String, completion: @escaping(Result<Data, DataError>) -> Void) {
        RestAPIClient.fetchRawData(route: .getImage(url: url), completion: completion)
    }
}
