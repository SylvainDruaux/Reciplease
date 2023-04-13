//
//  IngredientRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import XCTest
@testable import Reciplease

class IngredientRepositoryTests: XCTestCase {
    func test_fetchIngredients_Success_CorrectData() {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        ingredientRepository.getIngredients(query: query) { result in
            // Then
            switch result {
            case .success(let ingredients):
                XCTAssertEqual(ingredients[0], "tomato")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_fetchIngredients_Failed_IncorrectResponse() {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseKO,
                                                                                   data: IngredientsResponseDataFake.ingredientCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        ingredientRepository.getIngredients(query: query) { result in
            // Then
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail("Error")
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_fetchIngredients_Failed_BadData() {
        // Given
        let query = "tom"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: IngredientsResponseDataFake.responseOK,
                                                                                   data: IngredientsResponseDataFake.ingredientBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let ingredientRepository = IngredientRepository(restAPIClient: restAPIClient)
//        let ingredientViewModel = IngredientViewModel(ingredientRepository: ingredientRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        ingredientRepository.getIngredients(query: query) { result in
            // Then
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail("Error")
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
