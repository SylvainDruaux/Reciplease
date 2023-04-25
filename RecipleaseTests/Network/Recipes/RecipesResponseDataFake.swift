//
//  RecipesResponseDataFake.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation

class RecipesResponseDataFake {
    
    // MARK: - Error
    class RecipeError: Error {}
    static let recipeError = RecipeError()
    
    // MARK: - Correct Data
    static var recipeCorrectData: Data? {
        let bundle = Bundle(for: RecipesResponseDataFake.self)
        let url = bundle.url(forResource: "EdamamRecipeCorrectData", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            return data
        } catch {
            return Data()
        }
    }
    
    static var recipeCorrectImageData: Data? {
        return Data()
    }
    
    // MARK: - Incorrect Data
    static let recipeIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://fake.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://fake.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
}
