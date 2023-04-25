//
//  FridgeIngredientDataSourceMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 24/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

final class FridgeIngredientDataSourceMock: FridgeIngredientDataSourceProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func save(fridgeIngredients: FridgeIngredients) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
    
    func getAll() async throws -> FridgeIngredients {
        switch hasError {
        case false:
            return ["FridgeIngredient1", "FridgeIngredient2"]
        case true:
            throw executeError
        }
    }
    
    func deleteAll() async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
