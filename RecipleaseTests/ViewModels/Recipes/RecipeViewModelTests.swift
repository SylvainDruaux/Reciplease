//
//  RecipeViewModelTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

@MainActor
class RecipeViewModelTests: XCTestCase {
    var recipeViewModel: RecipeViewModel!
    
    override func setUp() {
        super.setUp()
        recipeViewModel = RecipeViewModel(
            fetchRecipesPageUseCase: FetchRecipesPageUseCaseMock(),
            fetchNextRecipesPageUseCase: FetchNextRecipesPageUseCaseMock(),
            fetchRecipeImageUseCase: FetchRecipeImageUseCaseMock()
        )
    }
    
    func test_fetchRecipes_Success() { // !! nextRecipesLink?
        // Given
        recipeViewModel = RecipeViewModel(fetchRecipesPageUseCase: FetchRecipesPageUseCaseMock())

        let ingredients = "FridgeIngredient1, FridgeIngredient2"

        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.recipes.bind { recipes in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(recipes.first?.label, "My recipe")
            }
            bindCount += 1
            expectation.fulfill()
        }

        // When
        recipeViewModel.fetchRecipes(ingredients)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchRecipes_Failure() {
        // Given
        recipeViewModel = RecipeViewModel(
            fetchRecipesPageUseCase: FetchRecipesPageUseCaseMock(hasError: true)
        )
        let ingredients = "FridgeIngredient1, FridgeIngredient2"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.viewModelError.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        
        // When
        recipeViewModel.fetchRecipes(ingredients)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchNextRecipes_Success() {
        // Given
        recipeViewModel.nextRecipesLink = "nextLink"

        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.recipes.bind { recipes in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(recipes.first?.label, "My recipe")
            }
            bindCount += 1
            expectation.fulfill()
        }

        // When
        recipeViewModel.fetchNextRecipes()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchNextRecipes_Failure() {
        // Given
        recipeViewModel = RecipeViewModel(
            fetchNextRecipesPageUseCase: FetchNextRecipesPageUseCaseMock(
                hasError: true
            )
        )
        recipeViewModel.nextRecipesLink = "nextLink"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.viewModelError.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        
        // When
        recipeViewModel.fetchNextRecipes()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchImage_Success() {
        // Given
        let imageUrl = "imageUrl"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.imageData.bind { imageData in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(imageData, Data())
            }
            bindCount += 1
            expectation.fulfill()
        }
        
        // When
        recipeViewModel.fetchImage(with: imageUrl)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_fetchImage_Failure() {
        // Given
        recipeViewModel = RecipeViewModel(
            fetchRecipeImageUseCase: FetchRecipeImageUseCaseMock(
                hasError: true
            )
        )
        let imageUrl = "imageUrl"
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        recipeViewModel.viewModelError.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        
        // When
        recipeViewModel.fetchImage(with: imageUrl)
        wait(for: [expectation], timeout: 0.05)
    }
}
