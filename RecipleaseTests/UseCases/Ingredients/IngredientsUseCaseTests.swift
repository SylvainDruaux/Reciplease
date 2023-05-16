//
//  IngredientsUseCaseTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 19/04/2023.
//

import XCTest
@testable import Reciplease

class IngredientsUseCaseTests: XCTestCase {
    var ingredientRepositoryMock: IngredientRepositoryMock!
    var searchIngredientsUseCase: SearchIngredientsUseCase!
    
    override func setUp() {
        super.setUp()
        ingredientRepositoryMock = IngredientRepositoryMock()
        searchIngredientsUseCase = SearchIngredientsUseCase(
            ingredientRepository: ingredientRepositoryMock
        )
    }
    
    func test_searchIngredientsUseCase_Success() async throws {
        // Given
        let query = "ing"
                
        // When
        let ingredients = try await searchIngredientsUseCase.execute(query: query)
        
        // Then
        XCTAssertEqual(ingredients, ["Ingredient1", "Ingredient2"])
    }
    
    func test_searchIngredientsUseCase_Failure() async throws {
        // Given
        let query = "ing"
        searchIngredientsUseCase = SearchIngredientsUseCase(
            ingredientRepository: IngredientRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await searchIngredientsUseCase.execute(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
}
