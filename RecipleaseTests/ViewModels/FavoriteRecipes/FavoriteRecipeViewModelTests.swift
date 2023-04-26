//
//  FavoriteRecipeViewModelTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

@MainActor
class FavoriteRecipeViewModelTests: XCTestCase {
    var saveFavoriteRecipesUseCaseMock: SaveFavoriteRecipesUseCaseMock!
    var fetchFavoriteRecipesUseCaseMock: FetchFavoriteRecipesUseCaseMock!
    var removeFavoriteRecipesUseCaseMock: RemoveFavoriteRecipesUseCaseMock!
    var favoriteRecipeViewModel: FavoriteRecipeViewModel!
    var recipe: Recipe!
    var newRecipe: Recipe!
    
    override func setUp() {
        super.setUp()
        saveFavoriteRecipesUseCaseMock = SaveFavoriteRecipesUseCaseMock()
        fetchFavoriteRecipesUseCaseMock = FetchFavoriteRecipesUseCaseMock()
        removeFavoriteRecipesUseCaseMock = RemoveFavoriteRecipesUseCaseMock()
        favoriteRecipeViewModel = FavoriteRecipeViewModel(
            saveFavoriteRecipesUseCase: saveFavoriteRecipesUseCaseMock,
            fetchFavoriteRecipesUseCase: fetchFavoriteRecipesUseCaseMock,
            removeFavoriteRecipesUseCase: removeFavoriteRecipesUseCaseMock
        )
        
        recipe = Recipe(
            label: "My recipe",
            imageUrl: "imageUrl",
            sourceUrl: "sourceUrl",
            yield: 6,
            ingredientLines: ["Ingredient1", "Ingredient2"],
            ingredients: [""],
            totalTime: 30.0
        )
        
        newRecipe = Recipe(
            label: "I am not a favorite",
            imageUrl: "imageUrl",
            sourceUrl: "sourceUrl",
            yield: 4,
            ingredientLines: ["They don't like me", "yet..."],
            ingredients: [""],
            totalTime: 90.0
        )
    }
    
    func test_userDidTapFavoriteButton_isNotFavorite() {
        // Given
        let expectation = expectation(description: #function)
        saveFavoriteRecipesUseCaseMock.mockExpectation = expectation
        
        // When
        favoriteRecipeViewModel.userDidTapFavoriteButton(with: newRecipe)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidTapFavoriteButton_isFavorite() {
        // Given
        let expectation = expectation(description: #function)
        removeFavoriteRecipesUseCaseMock.mockExpectation = expectation
        
        // When
        favoriteRecipeViewModel.userDidTapFavoriteButton(with: recipe)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidTapFavoriteButton_Failure() {
        // Given
        favoriteRecipeViewModel = FavoriteRecipeViewModel(
            fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseMock(hasError: true)
        )
        favoriteRecipeViewModel.errorDescription.value = ""
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.userDidTapFavoriteButton(with: recipe)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidTapFavoritesNavItem_Success() {
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.recipes.bind { recipes in
            if bindCount == 1 {
                // Then
                guard let recipes else { return }
                XCTAssertEqual(recipes.first?.label, "My recipe")
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.userDidTapFavoritesNavItem()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_userDidTapFavoritesNavItem_Failure() {
        // Given
        favoriteRecipeViewModel = FavoriteRecipeViewModel(
            fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseMock(hasError: true)
        )
        favoriteRecipeViewModel.errorDescription.value = ""
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.userDidTapFavoritesNavItem()
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_isFavorite() {
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.isFavorite.bind { result in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(result, true)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.isFavorite(recipe: recipe)
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_isNotFavorite() {
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.isFavorite.bind { result in
            if bindCount == 1 {
                // Then
                XCTAssertEqual(result, false)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.isFavorite(
            recipe: Recipe(
                label: "I am not a favorite",
                imageUrl: "imageUrl",
                sourceUrl: "sourceUrl",
                yield: 5,
                ingredientLines: ["they don't like me"],
                ingredients: [""],
                totalTime: 90.0
            )
        )
        wait(for: [expectation], timeout: 0.05)
    }
    
    func test_isFavorite_Failure() {
        // Given
        favoriteRecipeViewModel = FavoriteRecipeViewModel(
            fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseMock(hasError: true)
        )
        favoriteRecipeViewModel.errorDescription.value = ""
        
        let expectation = expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        var bindCount = 0
        
        favoriteRecipeViewModel.errorDescription.bind { error in
            if bindCount == 1 {
                // Then
                XCTAssertGreaterThan(error.count, 0)
            }
            bindCount += 1
            expectation.fulfill()
        }
        // When
        favoriteRecipeViewModel.isFavorite(recipe: recipe)
        wait(for: [expectation], timeout: 0.05)
    }
}
