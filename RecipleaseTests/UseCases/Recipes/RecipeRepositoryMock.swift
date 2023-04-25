//
//  RecipeRepositoryMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import Foundation
@testable import Reciplease

final class RecipeRepositoryMock: RecipeRepositoryProtocol {
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    private let recipesPageFake: RecipesPage
    
    init(hasError: Bool = false) {
        self.hasError = hasError
        recipesPageFake = RecipesPage(nextPage: "nextPage", recipes: [
            Recipe(label: "My recipe",
                   imageUrl: "imageUrl",
                   sourceUrl: "sourceUrl",
                   yield: 4,
                   ingredientLines: ["Ingredient1", "Ingredient2"],
                   ingredients: [""],
                   totalTime: 30.0)
        ])
    }
    
    // MARK: - API call
    func getRecipes(query: String) async throws -> RecipesPage {
        switch hasError {
        case false:
            return recipesPageFake
        case true:
            throw executeError
        }
    }
    
    func getNextRecipes(url: String) async throws -> RecipesPage {
        switch hasError {
        case false:
            return recipesPageFake
        case true:
            throw executeError
        }
    }
    
    func getImage(url: String) async throws -> Data {
        switch hasError {
        case false:
            return Data()
        case true:
            throw executeError
        }
    }
}
