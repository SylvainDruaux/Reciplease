//
//  RecipeRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 13/04/2023.
//

import XCTest
@testable import Reciplease

class RecipeRepositoryTests: XCTestCase {
    func test_fetchRecipes_Success_CorrectData() async throws {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        let recipesPage = try await recipeRepository.getRecipes(query: query)
        let recipes = recipesPage.recipes
        let nextRecipesLink = recipesPage.nextPage ?? ""
        
        // Then
        XCTAssertEqual(recipes.first?.label, "Fresh Tomato & Mozzarella Pasta!")
        XCTAssertEqual(nextRecipesLink, "https://api.edamam.com/api/recipes/v2?q=tomato%2C%20mozzarella%2C%20pasta&app_key=appkey&_cont=cont&type=public&app_id=appid")
    }
    
    func test_fetchRecipes_Failed_IncorrectResponse() async {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseKO,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await recipeRepository.getRecipes(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchRecipes_Failed_IncorrectData() async {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeIncorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await recipeRepository.getRecipes(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_getNextRecipes_Success_CorectData() async throws {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        let recipesPage = try await recipeRepository.getNextRecipes(url: url)
        let recipes = recipesPage.recipes
        let nextRecipesLink = recipesPage.nextPage ?? ""
        
        // Then
        XCTAssertEqual(recipes.first?.label, "Fresh Tomato & Mozzarella Pasta!")
        XCTAssertEqual(nextRecipesLink, "https://api.edamam.com/api/recipes/v2?q=tomato%2C%20mozzarella%2C%20pasta&app_key=appkey&_cont=cont&type=public&app_id=appid")
    }
    
    func test_getNextRecipes_Failed_IncorrectResponse() async throws {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseKO,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await recipeRepository.getNextRecipes(url: url)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_getNextRecipes_Failed_IncorrectData() async {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeIncorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await recipeRepository.getNextRecipes(url: url)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_getImage_Success_CorrectData() async throws {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        
        // When
        let imageData = try await recipeRepository.getImage(url: url)
        
        // Then
        XCTAssertNotNil(imageData)
    }
}
