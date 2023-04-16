//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

final class RecipeRepository: RecipeRepositoryProtocol {
    
    private let restAPIClient: RestAPIClientProtocol
    private let dataSource: FavoriteRecipeDataSourceProtocol
    
    init(restAPIClient: RestAPIClientProtocol = RestAPIClient(), dataSource: FavoriteRecipeDataSourceProtocol = FavoriteRecipeDataSource()) {
        self.restAPIClient = restAPIClient
        self.dataSource = dataSource
    }
    
    // MARK: - API call
    func getRecipes(query: String) async throws -> RecipeResponseDTO {
        try await restAPIClient.fetchData(route: .getRecipes(query: query))
    }
    
    func getNextRecipes(url: String) async throws -> RecipeResponseDTO {
        try await restAPIClient.fetchData(route: .getNextRecipes(url: url))
    }
    
    func getImage(url: String) async throws -> Data {
        try await restAPIClient.fetchRawData(route: .getImage(url: url))
    }
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws {
        do {
            try await dataSource.create(recipe: recipe)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFavoriteRecipes() async throws -> [RecipeEntity] {
        do {
            return try await dataSource.getAll()
        } catch {
            throw error
        }
    }
    
    func deleteFavoriteRecipe(_ id: UUID) async throws {
        do {
            try await dataSource.delete(id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
