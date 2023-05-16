//
//  FavoriteRecipesUseCasesTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

class FavoriteRecipesUseCasesTests: XCTestCase {
    var recipe: Recipe!
    var favoriteRecipeRepositoryMock: FavoriteRecipeRepositoryMock!
    var saveFavoriteRecipesUseCase: SaveFavoriteRecipesUseCase!
    var fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCase!
    var removeFavoriteRecipesUseCase: RemoveFavoriteRecipesUseCase!
    
    override func setUp() {
        super.setUp()
        recipe = Recipe(
            label: "label",
            imageUrl: "imageUrl",
            sourceUrl: "sourceUrl",
            yield: 4,
            ingredientLines: [""],
            ingredients: [""],
            totalTime: 30.0
        )
        favoriteRecipeRepositoryMock = FavoriteRecipeRepositoryMock()
        saveFavoriteRecipesUseCase = SaveFavoriteRecipesUseCase(favoriteRecipeRepository: favoriteRecipeRepositoryMock)
        fetchFavoriteRecipesUseCase = FetchFavoriteRecipesUseCase(favoriteRecipeRepository: favoriteRecipeRepositoryMock)
        removeFavoriteRecipesUseCase = RemoveFavoriteRecipesUseCase(favoriteRecipeRepository: favoriteRecipeRepositoryMock)
    }
    
    func test_saveFavoriteRecipesUseCase_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        favoriteRecipeRepositoryMock.mockExpectation = expectation
        
        // When
        try await saveFavoriteRecipesUseCase.execute(recipe)
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_saveFavoriteRecipesUseCase_Failure() async throws {
        // Given
        saveFavoriteRecipesUseCase = SaveFavoriteRecipesUseCase(
            favoriteRecipeRepository: FavoriteRecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            try await saveFavoriteRecipesUseCase.execute(recipe)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchFavoriteRecipesUseCase_Success() async throws {
        // When
        let recipes = try await fetchFavoriteRecipesUseCase.execute()
        
        // Then
        XCTAssertEqual(recipes.first?.totalTime, 30.0)
    }
    
    func test_fetchFavoriteRecipesUseCase_Failure() async throws {
        // Given
        fetchFavoriteRecipesUseCase = FetchFavoriteRecipesUseCase(
            favoriteRecipeRepository: FavoriteRecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await fetchFavoriteRecipesUseCase.execute()
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_removeFavoriteRecipesUseCase_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        favoriteRecipeRepositoryMock.mockExpectation = expectation
        
        // When
        try await removeFavoriteRecipesUseCase.execute(recipe.id)
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_removeFavoriteRecipesUseCase_Failure() async throws {
        // Given
        removeFavoriteRecipesUseCase = RemoveFavoriteRecipesUseCase(
            favoriteRecipeRepository: FavoriteRecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            try await removeFavoriteRecipesUseCase.execute(recipe.id)
            // Then
            XCTFail("Error")
        } catch { }
    }
}
