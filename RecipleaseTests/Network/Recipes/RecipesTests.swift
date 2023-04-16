//
//  RecipesTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 13/04/2023.
//

import XCTest
@testable import Reciplease

class RecipesTests: XCTestCase {
    func test_fetchRecipes_Success_CorrectData() async throws {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        let recipeResponse = try await searchRecipesUseCase.getRecipes(query: query)
        let recipes = recipeResponse.toDomain().recipes
        let nextRecipesLink = recipeResponse.toDomain().nextPage ?? ""
        
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
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        do {
            _ = try await searchRecipesUseCase.getRecipes(query: query)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
    
    func test_fetchRecipes_Failed_BadData() async {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        do {
            _ = try await searchRecipesUseCase.getRecipes(query: query)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
    
    func test_getNextRecipes_Success_CorectData() async throws {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        let recipeResponse = try await searchRecipesUseCase.getNextRecipes(url: url)
        let recipes = recipeResponse.toDomain().recipes
        let nextRecipesLink = recipeResponse.toDomain().nextPage ?? ""
        
        // Then
        XCTAssertEqual(recipes.first?.label, "Fresh Tomato & Mozzarella Pasta!")
        XCTAssertEqual(nextRecipesLink, "https://api.edamam.com/api/recipes/v2?q=tomato%2C%20mozzarella%2C%20pasta&app_key=appkey&_cont=cont&type=public&app_id=appid")
    }
    
    func test_getNextRecipes_Failed_IncorrectResponse() async {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseKO,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        do {
            _ = try await searchRecipesUseCase.getNextRecipes(url: url)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
    
    func test_getNextRecipes_Failed_BadData() async {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        do {
            _ = try await searchRecipesUseCase.getNextRecipes(url: url)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
    
    func test_getImage_Success_CorrectData() async throws {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        let searchRecipesUseCase = SearchRecipesUseCase(recipeRepository: recipeRepository)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        // When
        let imageData = try await searchRecipesUseCase.getImage(url: url)
        
        // Then
        XCTAssertNotNil(imageData)
    }
}
