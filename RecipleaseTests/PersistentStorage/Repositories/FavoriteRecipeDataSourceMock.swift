//
//  FavoriteRecipeDataSourceMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 24/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

final class FavoriteRecipeDataSourceMock: FavoriteRecipeDataSourceProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func create(recipe: Recipe) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
    
    func getAll() async throws -> [RecipeEntity] {
        switch hasError {
        case false: // Can't create a mock (CoreData required)
//            return [RecipeEntity()]
            throw executeError
        case true:
            throw executeError
        }
    }
    
    func delete(_ id: String) async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
