//
//  FavoriteRecipeRepositoryMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

class FavoriteRecipeRepositoryMock: FavoriteRecipeRepositoryProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    // MARK: - Persistent Storage
    func createFavoriteRecipe(_ recipe: Recipe) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
    
    func getFavoriteRecipes() async throws -> [Recipe] {
        switch hasError {
        case false:
            return [Recipe(label: "My recipe",
                          imageUrl: "imageUrl",
                          sourceUrl: "sourceUrl",
                          yield: 4,
                          ingredientLines: ["Ingredient1", "Ingredient2"],
                          ingredients: [""],
                          totalTime: 30.0)]
        case true:
            throw executeError
        }
    }
    
    func deleteFavoriteRecipe(_ id: String) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
