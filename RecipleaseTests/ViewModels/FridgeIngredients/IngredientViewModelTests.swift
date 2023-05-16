//
//  IngredientViewModelTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

@MainActor
class IngredientViewModelTests: XCTestCase {
    var searchIngredientsUseCaseMock: SearchIngredientsUseCaseMock!
    var saveFridgeIngredientsUseCaseMock: SaveFridgeIngredientsUseCaseMock!
    var fetchFridgeIngredientsUseCaseMock: FetchFridgeIngredientsUseCaseMock!
    var removeFridgeIngredientsUseCaseMock: RemoveFridgeIngredientsUseCaseMock!
    var ingredientViewModel: IngredientViewModel!
    
    override func setUp() {
        super.setUp()
        searchIngredientsUseCaseMock = SearchIngredientsUseCaseMock()
        saveFridgeIngredientsUseCaseMock = SaveFridgeIngredientsUseCaseMock()
        fetchFridgeIngredientsUseCaseMock = FetchFridgeIngredientsUseCaseMock()
        removeFridgeIngredientsUseCaseMock = RemoveFridgeIngredientsUseCaseMock()
        ingredientViewModel = IngredientViewModel(
            searchIngredientsUseCase: searchIngredientsUseCaseMock,
            saveFridgeIngredientsUseCase: saveFridgeIngredientsUseCaseMock,
            fetchFridgeIngredientsUseCase: fetchFridgeIngredientsUseCaseMock,
            removeFridgeIngredientsUseCase: removeFridgeIngredientsUseCaseMock
        )
    }
    
    func test_fetchIngredients_Success() {
        // Given
        let query = "tom"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        ingredientViewModel.ingredients.bind { ingredients in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(ingredients, ["Ingredient1", "Ingredient2"])
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        ingredientViewModel.fetchIngredients(startingWith: query)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchIngredients_Failure() {
        // Given
        ingredientViewModel = IngredientViewModel(
            searchIngredientsUseCase: SearchIngredientsUseCaseMock(
                hasError: true
            )
        )
        let query = "tom"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        ingredientViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        ingredientViewModel.fetchIngredients(startingWith: query)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidTapClearList() {
        // When
        ingredientViewModel = IngredientViewModel()
        ingredientViewModel.fridgeIngredients.value = ["not empty"]
        ingredientViewModel.userDidTapClearList()
        // Then
        XCTAssertTrue(ingredientViewModel.fridgeIngredients.value.isEmpty)
    }
    
    func test_userDidTapSearchButton_Success() {
        // Given
        let expectation1 = expectation(description: #function)
        removeFridgeIngredientsUseCaseMock.mockExpectation = expectation1
        let expectation2 = expectation(description: #function)
        saveFridgeIngredientsUseCaseMock.mockExpectation = expectation2
        
        // When
        ingredientViewModel.userDidTapSearchButton()
        wait(for: [expectation1, expectation2], timeout: 0.05)
    }
    
    func test_userDidTapSearchButton_Failure() {
        // Given
        ingredientViewModel = IngredientViewModel(
            removeFridgeIngredientsUseCase: RemoveFridgeIngredientsUseCaseMock(
                hasError: true
            )
        )
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        ingredientViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        ingredientViewModel.userDidTapSearchButton()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidLoadPreviousList_Success() {
        // Given
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        ingredientViewModel.fridgeIngredients.bind { fridgeIngredients in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(fridgeIngredients, ["FridgeIngredient1", "FridgeIngredient2"])
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        ingredientViewModel.userDidLoadPreviousList()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidLoadPreviousList_Failure() {
        // Given
        ingredientViewModel = IngredientViewModel(
            fetchFridgeIngredientsUseCase: FetchFridgeIngredientsUseCaseMock(
                hasError: true
            )
        )
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        ingredientViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        ingredientViewModel.userDidLoadPreviousList()
        wait(for: [expectation], timeout: 0.05)
    }
}
