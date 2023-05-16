//
//  SaveFridgeIngredientsUseCaseMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

final class SaveFridgeIngredientsUseCaseMock: SaveFridgeIngredientsUseCaseProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func execute(_ fridgeIngredients: FridgeIngredients) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
