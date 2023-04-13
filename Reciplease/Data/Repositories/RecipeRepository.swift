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
    func getRecipes(query: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void) {
        RestAPIClient.shared.fetchData(route: .getRecipes(query: query), completion: completion)
    }
    
    func getNextRecipes(url: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void) {
        RestAPIClient.shared.fetchData(route: .getNextRecipes(url: url), completion: completion)
    }
    
    func getImage(url: String, completion: @escaping(Result<Data, DataError>) -> Void) {
        RestAPIClient.shared.fetchRawData(route: .getImage(url: url), completion: completion)
    }
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws {
        do {
            try await dataSource.create(recipe: recipe)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFavoriteRecipes() async throws -> [RecipeEntity]? {
        do {
            return try await dataSource.getAll()
        } catch {
            print(error.localizedDescription)
            return nil
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
