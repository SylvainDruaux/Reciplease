//
//  FridgeIngredientRepositoryMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

final class FridgeIngredientRepositoryMock: FridgeIngredientRepositoryProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    // MARK: - Persistent Storage
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
    
    func getFridgeIngredients() async throws -> FridgeIngredients {
        switch hasError {
        case false:
            return ["FridgeIngredient1", "FridgeIngredient2"]
        case true:
            throw executeError
        }
    }
    
    func deleteFridgeIngredients() async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
