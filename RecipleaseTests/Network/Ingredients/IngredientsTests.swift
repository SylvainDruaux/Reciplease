//
//  IngredientsTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import XCTest
@testable import Reciplease

class IngredientsTests: XCTestCase {
    func test_fetchIngredients_Success_CorrectData() async throws {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        let searchIngredientsUseCase = SearchIngredientsUseCase(ingredientRepository: ingredientRepository)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        // When
        let ingredients = try await searchIngredientsUseCase.getIngredients(query: query)
        
        // Then
        XCTAssertEqual(ingredients[0], "tomato")
    }
    
    func test_fetchIngredients_Failed_IncorrectResponse() async {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseKO,
                                                                                   data: IngredientsResponseDataFake.ingredientCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        let searchIngredientsUseCase = SearchIngredientsUseCase(ingredientRepository: ingredientRepository)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        // When
        do {
            _ = try await searchIngredientsUseCase.getIngredients(query: query)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
    
    func test_fetchIngredients_Failed_BadData() async {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        let searchIngredientsUseCase = SearchIngredientsUseCase(ingredientRepository: ingredientRepository)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        // When
        do {
            _ = try await searchIngredientsUseCase.getIngredients(query: query)
        } catch {
            // Then
            XCTFail("Error")
        }
    }
}
