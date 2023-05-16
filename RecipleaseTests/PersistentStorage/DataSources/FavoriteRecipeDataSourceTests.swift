//
//  FavoriteRecipeDataSourceTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 24/04/2023.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteRecipeDataSourceTests: XCTestCase {
    var favoriteRecipeDataSource: FavoriteRecipeDataSource!
    var favoriteRecipe: Recipe!
    
    override func setUp() {
        super.setUp()
        favoriteRecipeDataSource = FavoriteRecipeDataSource(coreDataStack: CoreDataStack(.inMemory))
        
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
        // When
        try await favoriteRecipeDataSource.create(recipe: favoriteRecipe)
        
        // Then
        let storedFavoriteRecipe = try await favoriteRecipeDataSource.getAll()
        XCTAssertEqual(storedFavoriteRecipe.last?.label, "my recipe")
    }
    
    func test_getAll_Success() async throws {
        // Given
        try await favoriteRecipeDataSource.create(recipe: favoriteRecipe)
                
        // When
        let storedFavoriteRecipe = try await favoriteRecipeDataSource.getAll()
        
        // Then
        XCTAssertEqual(storedFavoriteRecipe.last?.ingredients, ["tomato, beef, cheese, salad leaf"])
    }
    
    func test_delete_Success() async throws {
        // Given
        try await favoriteRecipeDataSource.create(recipe: favoriteRecipe)
                
        // When
        try await favoriteRecipeDataSource.delete(favoriteRecipe.id)
        
        // Then
        let storedFavoriteRecipe = try await favoriteRecipeDataSource.getAll()
        XCTAssertFalse(storedFavoriteRecipe.contains { $0.id == favoriteRecipe.id })
    }
}
