//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

final class RecipeRepository: RecipeRepositoryProtocol {
    
    private let restAPIClient: RestAPIClientProtocol
    
    init(restAPIClient: RestAPIClientProtocol = RestAPIClient()) {
        self.restAPIClient = restAPIClient
    }
    
    // MARK: - API call
    func getRecipes(query: String) async throws -> RecipesPage {
        let recipeResponseDTO: RecipeResponseDTO = try await restAPIClient.fetchData(route: .getRecipes(query: query))
        return recipeResponseDTO.toDomain()
    }
    
    func getNextRecipes(url: String) async throws -> RecipesPage {
        let recipeResponseDTO: RecipeResponseDTO = try await restAPIClient.fetchData(route: .getNextRecipes(url: url))
        return recipeResponseDTO.toDomain()
    }
    
    func getImage(url: String) async throws -> Data {
        try await restAPIClient.fetchRawData(route: .getImage(url: url))
    }
}
