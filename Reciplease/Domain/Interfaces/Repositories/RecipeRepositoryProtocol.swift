//
//  RecipeRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol RecipeRepositoryProtocol {
    // MARK: - API call
    func getRecipes(query: String) async throws -> RecipesPage
    func getNextRecipes(url: String) async throws -> RecipesPage
    func getImage(url: String) async throws -> Data
}
