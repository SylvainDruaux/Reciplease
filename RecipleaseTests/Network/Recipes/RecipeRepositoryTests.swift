//
//  RecipeRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 13/04/2023.
//

import XCTest
@testable import Reciplease

class RecipeRepositoryTests: XCTestCase {
    func test_fetchRecipes_Success_CorrectData() {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getRecipes(query: query) { result in
            // Then
            switch result {
            case .success(let recipeResponseDTO):
                let recipes = recipeResponseDTO.toDomain().recipes
                XCTAssertEqual(recipes.first?.label, "Fresh Tomato & Mozzarella Pasta!")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func test_fetchRecipes_Failed_IncorrectResponse() {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseKO,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
//        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getRecipes(query: query) { result in
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
        wait(for: [expectation], timeout: 3)
    }
    
    func test_fetchRecipes_Failed_BadData() {
        // Given
        let query = "tomato, mozzarella, pasta"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        //        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getRecipes(query: query) { result in
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
        wait(for: [expectation], timeout: 3)
    }
    
    func test_getNextRecipes_Success_CorectData() {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        //        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getNextRecipes(url: url) { result in
            // Then
            switch result {
            case .success(let recipeResponseDTO):
                let recipes = recipeResponseDTO.toDomain().recipes
                XCTAssertEqual(recipes.first?.label, "Fresh Tomato & Mozzarella Pasta!")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func test_getNextRecipes_Failed_IncorrectResponse() {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseKO,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        //        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getNextRecipes(url: url) { result in
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
        wait(for: [expectation], timeout: 3)
    }
    
    func test_getNextRecipes_Failed_BadData() {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeBadData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        //        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getNextRecipes(url: url) { result in
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
        wait(for: [expectation], timeout: 3)
    }
    
    func test_getImage_Success_CorrectData() {
        // Given
        let url = "https://fake.com"
        
        let alamofireServiceMock = AlamofireServiceMock(responseMock: ResponseMock(response: RecipesResponseDataFake.responseOK,
                                                                                   data: RecipesResponseDataFake.recipeCorrectData)
        )
        let restAPIClient = RestAPIClient(alamofireService: alamofireServiceMock)
        let recipeRepository = RecipeRepository(restAPIClient: restAPIClient)
        //        let recipeViewModel = RecipeViewModel(recipeRepository: recipeRepository)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        recipeRepository.getImage(url: url) { result in
            // Then
            switch result {
            case .success(let imageData):
                XCTAssertNotNil(imageData)
            case .failure:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
