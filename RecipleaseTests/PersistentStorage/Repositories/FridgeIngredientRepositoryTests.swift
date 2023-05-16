//
//  FridgeIngredientRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 18/04/2023.
//

import XCTest
import CoreData
@testable import Reciplease

class FridgeIngredientRepositoryTests: XCTestCase {
    var fridgeIngredientDataSourceMock: FridgeIngredientDataSourceMock!
    var fridgeIngredientRepository: FridgeIngredientRepository!
    var fridgeIngredients: FridgeIngredients!
    
    override func setUp() {
        super.setUp()
        fridgeIngredientDataSourceMock = FridgeIngredientDataSourceMock()
        fridgeIngredientRepository = FridgeIngredientRepository(dataSource: fridgeIngredientDataSourceMock)
        fridgeIngredients = ["tomato", "beef", "cheese", "salad leaf"]
    }
    
    func test_saveFridgeIngredients_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        fridgeIngredientDataSourceMock.mockExpectation = expectation
        
        // When
        try await fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredients)
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_saveFridgeIngredients_Failure() async throws {
        // Given
        fridgeIngredientRepository = FridgeIngredientRepository(dataSource: FridgeIngredientDataSourceMock(hasError: true))
        
        // When
        do {
            try await fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredients)
            XCTFail("Error")
        } catch { }
    }
    
    func test_getFridgeIngredients_Success() async throws {
        // When
        let fridgeIngredients = try await fridgeIngredientRepository.getFridgeIngredients()
        
        // Then
        XCTAssertEqual(fridgeIngredients, ["FridgeIngredient1", "FridgeIngredient2"])
    }
    
    func test_getFridgeIngredients_Failure() async throws {
        // Given
        fridgeIngredientRepository = FridgeIngredientRepository(dataSource: FridgeIngredientDataSourceMock(hasError: true))
        
        // When
        do {
            _ = try await fridgeIngredientRepository.getFridgeIngredients()
            XCTFail("Error")
        } catch { }
    }
    
    func test_deleteFridgeIngredients_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        fridgeIngredientDataSourceMock.mockExpectation = expectation
        
        // When
        try await fridgeIngredientRepository.deleteFridgeIngredients()
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_deleteFridgeIngredients_Failure() async throws {
        fridgeIngredientRepository = FridgeIngredientRepository(dataSource: FridgeIngredientDataSourceMock(hasError: true))
        
        // When
        do {
            try await fridgeIngredientRepository.deleteFridgeIngredients()
            XCTFail("Error")
        } catch { }
    }
}
