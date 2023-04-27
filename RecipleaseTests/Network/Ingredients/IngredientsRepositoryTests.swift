//
//  IngredientsRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import XCTest
@testable import Reciplease

class IngredientsRepositoryTests: XCTestCase {
    func test_fetchIngredients_Success_CorrectData() async throws {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        
        // When
        let ingredients = try await ingredientRepository.getIngredients(query: query)
        
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
        
        // When
        do {
            _ = try await ingredientRepository.getIngredients(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchIngredients_Failed_IncorrectData() async {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientIncorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await ingredientRepository.getIngredients(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
    
    func test_fetchIngredients_Failed_NoData() async {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientNoData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
        
        // When
        do {
            _ = try await ingredientRepository.getIngredients(query: query)
            // Then
            XCTFail("Error")
        } catch { }
    }
}
