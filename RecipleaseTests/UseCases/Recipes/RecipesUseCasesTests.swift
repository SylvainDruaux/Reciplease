//
//  RecipeUseCasesTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import XCTest
@testable import Reciplease

class RecipesUseCasesTests: XCTestCase {
    var recipeRepositoryMock: RecipeRepositoryMock!
    var fetchRecipesPageUseCase: FetchRecipesPageUseCase!
    var fetchNextRecipesPageUseCase: FetchNextRecipesPageUseCase!
    var fetchRecipeImageUseCase: FetchRecipeImageUseCase!
    
    override func setUp() {
        super.setUp()
        recipeRepositoryMock = RecipeRepositoryMock()
        fetchRecipesPageUseCase = FetchRecipesPageUseCase(recipeRepository: recipeRepositoryMock)
        fetchNextRecipesPageUseCase = FetchNextRecipesPageUseCase(recipeRepository: recipeRepositoryMock)
        fetchRecipeImageUseCase = FetchRecipeImageUseCase(recipeRepository: recipeRepositoryMock)
    }
    
    func test_fetchRecipesPageUseCase_Success() async throws {
        // Given
        let query = "tomato, onion"
        
        // When
        let recipesPage = try await fetchRecipesPageUseCase.execute(query: query)
        
        // Then
        XCTAssertEqual(recipesPage.recipes.first?.label, "My recipe")
    }
    
    func test_fetchRecipesPageUseCase_Failure() async throws {
        // Given
        let query = "tomato, onion"
        fetchRecipesPageUseCase = FetchRecipesPageUseCase(
            recipeRepository: RecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await fetchRecipesPageUseCase.execute(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchNextRecpiesPageUseCase_Success() async throws {
        // Given
        let nextpageUrl = "nextpageUrl"
        
        // When
        let recipesPage = try await fetchNextRecipesPageUseCase.execute(url: nextpageUrl)
        
        // Then
        XCTAssertEqual(recipesPage.recipes.first?.ingredientLines, ["Ingredient1", "Ingredient2"])
    }
    
    func test_fetchNextRecpiesPageUseCase_Failure() async throws {
        // Given
        let nextpageUrl = "nextpageUrl"
        fetchNextRecipesPageUseCase = FetchNextRecipesPageUseCase(
            recipeRepository: RecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await fetchNextRecipesPageUseCase.execute(url: nextpageUrl)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchRecipeImageUseCase_Success() async throws {
        // Given
        let imageUrl = "imageUrl"
        
        // When
        let recipeImage = try await fetchRecipeImageUseCase.execute(url: imageUrl)
        
        // Then
        XCTAssertEqual(recipeImage, Data())
    }
    
    func test_fetchRecipeImageUseCase_Failure() async throws {
        // Given
        let imageUrl = "imageUrl"
        fetchRecipeImageUseCase = FetchRecipeImageUseCase(
            recipeRepository: RecipeRepositoryMock(hasError: true)
        )
        
        // When
        do {
            _ = try await fetchRecipeImageUseCase.execute(url: imageUrl)
            // Then
            XCTFail("Error")
        } catch { }
    }
}
