//
//  APIRouterTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 14/04/2023.
//

import XCTest
import Alamofire
@testable import Reciplease

class APIRouterTests: XCTestCase {
    func test_getIngredients() throws {
        // Given
        let query = "tom"
        let urlBase = AppConfiguration.shared.foodBaseURL
        var urlParams = [String: Any]()
        urlParams["app_id"] = AppConfiguration.shared.foodAppId
        urlParams["app_key"] = AppConfiguration.shared.foodApiKey
        urlParams["q"] = query
        
        // When
        let value = APIRouter.getIngredients(query: query)
        
        // Then
        let url = try urlBase.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParams)
        XCTAssertEqual(try value.asURLRequest(), urlRequest)
    }
    
    func test_getRecipes() throws {
        // Given
        let query = "tomato"
        let urlBase = AppConfiguration.shared.recipeBaseURL
        var urlParams = [String: Any]()
        urlParams["type"] = "public"
        urlParams["app_id"] = AppConfiguration.shared.recipeAppId
        urlParams["app_key"] = AppConfiguration.shared.recipeApiKey
        urlParams["q"] = query
        
        // When
        let value = APIRouter.getRecipes(query: query)
        
        // Then
        let url = try urlBase.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParams)
        XCTAssertEqual(try value.asURLRequest(), urlRequest)
    }
    
    func test_getNextRecipes() throws {
        // Given
        let nextRecipeUrl = "https://fake.com"
        let urlParams = [String: Any]()

        // When
        let value = APIRouter.getNextRecipes(url: nextRecipeUrl)
        
        // Then
        let url = try nextRecipeUrl.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParams)
        XCTAssertEqual(try value.asURLRequest(), urlRequest)
    }
    
    func test_getImage() throws {
        // Given
        let imageUrl = "https://fake.com"
        let urlParams = [String: Any]()
        
        // When
        let value = APIRouter.getImage(url: imageUrl)
        
        // Then
        let url = try imageUrl.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParams)
        XCTAssertEqual(try value.asURLRequest(), urlRequest)
    }
}
