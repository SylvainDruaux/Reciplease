//
//  FetchFavoriteRecipesUseCaseMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 21/04/2023.
//

import Foundation
@testable import Reciplease

final class FetchFavoriteRecipesUseCaseMock: FetchFavoriteRecipesUseCaseProtocol {
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func execute() async throws -> [Recipe] {
        switch hasError {
        case false:
            return [
                Recipe(
                    label: "My recipe",
                    imageUrl: "imageUrl",
                    sourceUrl: "sourceUrl",
                    yield: 4,
                    ingredientLines: ["Ingredient1", "Ingredient2"],
                    ingredients: [""],
                    totalTime: 30.0
                )
            ]
        case true:
            throw executeError
        }
    }
}
