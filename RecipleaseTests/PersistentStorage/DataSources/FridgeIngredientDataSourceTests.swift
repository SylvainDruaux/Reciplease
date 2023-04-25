//
//  FridgeIngredientDataSourceTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 24/04/2023.
//

import XCTest
import CoreData
@testable import Reciplease

class FridgeIngredientDataSourceTests: XCTestCase {
    var fridgeIngredientDataSource: FridgeIngredientDataSource!
    var fridgeIngredients: FridgeIngredients!
    
    override func setUp() {
        super.setUp()
        fridgeIngredientDataSource = FridgeIngredientDataSource(coreDataStack: CoreDataStack(.inMemory))
        fridgeIngredients = ["tomato", "beef", "cheese", "salad leaf"]
    }
    
    func test_save_Success() async throws {
        // When
        try await fridgeIngredientDataSource.deleteAll()
        try await fridgeIngredientDataSource.save(fridgeIngredients: fridgeIngredients)
        
        // Then
        let storedFridgeIngredients = try await fridgeIngredientDataSource.getAll()
        XCTAssertEqual(storedFridgeIngredients, ["tomato", "beef", "cheese", "salad leaf"])
    }
    
    func test_getAll_Success() async throws {
        // Given
        try await fridgeIngredientDataSource.deleteAll()
        try await fridgeIngredientDataSource.save(fridgeIngredients: fridgeIngredients)
        
        // When
        let storedFridgeIngredients = try await fridgeIngredientDataSource.getAll()
        
        // Then
        XCTAssertEqual(storedFridgeIngredients, ["tomato", "beef", "cheese", "salad leaf"])
    }
    
    func test_deleteAll_Success() async throws {
        // Given
        try await fridgeIngredientDataSource.deleteAll()
        try await fridgeIngredientDataSource.save(fridgeIngredients: fridgeIngredients)
        
        // When
        try await fridgeIngredientDataSource.deleteAll()
        
        // Then
        let storedFridgeIngredients = try await fridgeIngredientDataSource.getAll()
        XCTAssertEqual(storedFridgeIngredients, [])
    }
}
