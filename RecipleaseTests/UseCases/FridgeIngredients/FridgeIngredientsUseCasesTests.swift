//
//  FridgeIngredientsUseCasesTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

class FridgeIngredientsUseCasesTests: XCTestCase {
    var fridgeIngredientRepositoryMock: FridgeIngredientRepositoryMock!
    var saveFridgeIngredientsUseCase: SaveFridgeIngredientsUseCase!
    var fetchFridgeIngredientsUseCase: FetchFridgeIngredientsUseCase!
    var removeFridgeIngredientsUseCase: RemoveFridgeIngredientsUseCase!
    
    override func setUp() {
        super.setUp()
        fridgeIngredientRepositoryMock = FridgeIngredientRepositoryMock()
        saveFridgeIngredientsUseCase = SaveFridgeIngredientsUseCase(fridgeIngredientRepository: fridgeIngredientRepositoryMock)
        fetchFridgeIngredientsUseCase = FetchFridgeIngredientsUseCase(fridgeIngredientRepository: fridgeIngredientRepositoryMock)
        removeFridgeIngredientsUseCase = RemoveFridgeIngredientsUseCase(fridgeIngredientRepository: fridgeIngredientRepositoryMock)
    }
    
    func test_saveFridgeIngredientsUseCase_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        fridgeIngredientRepositoryMock.mockExpectation = expectation
        let fridgeIngredients = ["FridgeIngredient1", "FridgeIngredient2"]
        
        // When
        try await saveFridgeIngredientsUseCase.execute(fridgeIngredients)
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_saveFridgeIngredientsUseCase_Failure() async throws {
        // Given
        saveFridgeIngredientsUseCase = SaveFridgeIngredientsUseCase(
            fridgeIngredientRepository: FridgeIngredientRepositoryMock(hasError: true)
        )
        let fridgeIngredients = ["FridgeIngredient1", "FridgeIngredient2"]
        
        // When
        do {
            try await saveFridgeIngredientsUseCase.execute(fridgeIngredients)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchFridgeIngredientsUseCase_Success() async throws {
        // When
        let fridgeIngredients = try await fetchFridgeIngredientsUseCase.execute()
        
        // Then
        XCTAssertEqual(fridgeIngredients, ["FridgeIngredient1", "FridgeIngredient2"])
    }
    
    func test_fetchFridgeIngredientsUseCase_Failure() async throws {
        // Given
        fetchFridgeIngredientsUseCase = FetchFridgeIngredientsUseCase(
            fridgeIngredientRepository: FridgeIngredientRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await fetchFridgeIngredientsUseCase.execute()
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_removeFridgeIngredientsUseCase_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        fridgeIngredientRepositoryMock.mockExpectation = expectation
        
        // When
        try await removeFridgeIngredientsUseCase.execute()
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_removeFridgeIngredientsUseCase_Failure() async throws {
        // Given
        removeFridgeIngredientsUseCase = RemoveFridgeIngredientsUseCase(
            fridgeIngredientRepository: FridgeIngredientRepositoryMock(hasError: true)
        )
        
        // When
        do {
            try await removeFridgeIngredientsUseCase.execute()
            // Then
            XCTFail("Error")
        } catch { }
    }
}
