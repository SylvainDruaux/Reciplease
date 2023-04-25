//
//  IngredientRepositoryMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 19/04/2023.
//

import Foundation
@testable import Reciplease

final class IngredientRepositoryMock: IngredientRepositoryProtocol {
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func getIngredients(query: String) async throws -> IngredientResponse {
        switch hasError {
        case false:
            return ["Ingredient1", "Ingredient2"]
        case true:
            throw executeError
        }
    }
}
