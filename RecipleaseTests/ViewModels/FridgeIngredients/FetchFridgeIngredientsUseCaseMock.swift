//
//  FetchFridgeIngredientsUseCaseMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 21/04/2023.
//

import Foundation
@testable import Reciplease

final class FetchFridgeIngredientsUseCaseMock: FetchFridgeIngredientsUseCaseProtocol {
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func execute() async throws -> FridgeIngredients {
        switch hasError {
        case false:
            return ["FridgeIngredient1", "FridgeIngredient2"]
        case true:
            throw executeError
        }
    }
}
