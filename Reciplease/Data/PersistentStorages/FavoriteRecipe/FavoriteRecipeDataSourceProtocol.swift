//
//  FavoriteRecipeDataSourceProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation

protocol FavoriteRecipeDataSourceProtocol {
    func create(recipe: Recipe) async throws
    func getAll() async throws -> [RecipeEntity]
    func delete(_ id: String) async throws
}
