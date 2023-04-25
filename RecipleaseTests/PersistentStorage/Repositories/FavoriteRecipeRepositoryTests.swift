//
//  FavoriteRecipeRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 18/04/2023.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteRecipeRepositoryTests: XCTestCase {
    var favoriteRecipeDataSourceMock: FavoriteRecipeDataSourceMock!
    var favoriteRecipeRepository: FavoriteRecipeRepository!
    var favoriteRecipe: Recipe!
    
    override func setUp() {
        super.setUp()
        favoriteRecipeDataSourceMock = FavoriteRecipeDataSourceMock()
        favoriteRecipeRepository = FavoriteRecipeRepository(dataSource: favoriteRecipeDataSourceMock)
        
        favoriteRecipe = Recipe(
            label: "my recipe",
            imageUrl: "image",
            sourceUrl: "https://recipe.com",
            yield: 4,
            ingredientLines: ["tomato, beef, cheese, salad leaf"],
            ingredients: ["tomato, beef, cheese, salad leaf"],
            totalTime: 30.0
        )
    }
    
    func test_create_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        favoriteRecipeDataSourceMock.mockExpectation = expectation
                
        // When
        try await favoriteRecipeRepository.createFavoriteRecipe(favoriteRecipe)
        
        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_create_Failure() async throws {
        // Given
        favoriteRecipeRepository = FavoriteRecipeRepository(
            dataSource: FavoriteRecipeDataSourceMock(hasError: true)
        )
        
        // When
        do {
            try await favoriteRecipeRepository.createFavoriteRecipe(favoriteRecipe)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_getFavoriteRecipes_Success() async throws {
        // Can't create a mock (CoreData required)
    }
    
    func test_getFavoriteRecipes_Failure() async throws {
        // Given
        favoriteRecipeRepository = FavoriteRecipeRepository(
            dataSource: FavoriteRecipeDataSourceMock(hasError: true)
        )
        
        // When
        do {
            _ = try await favoriteRecipeRepository.getFavoriteRecipes()
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_deleteFavoriteRecipe_Success() async throws {
        // Given
        let expectation = expectation(description: #function)
        favoriteRecipeDataSourceMock.mockExpectation = expectation
        
        // When
        try await favoriteRecipeRepository.deleteFavoriteRecipe(favoriteRecipe.id)

        // Then
        await fulfillment(of: [expectation])
    }
    
    func test_deleteFavoriteRecipe_Failure() async throws {
        // Given
        favoriteRecipeRepository = FavoriteRecipeRepository(
            dataSource: FavoriteRecipeDataSourceMock(hasError: true)
        )
        
        // When
        do {
            try await favoriteRecipeRepository.deleteFavoriteRecipe(favoriteRecipe.id)
            // Then
            XCTFail("Error")
        } catch { }
    }
}
