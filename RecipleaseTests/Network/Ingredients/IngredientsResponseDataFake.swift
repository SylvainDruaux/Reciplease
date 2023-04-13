//
//  IngredientsResponseDataFake.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation

class IngredientsResponseDataFake {
    
    // MARK: - Error
    class IngredientError: Error {}
    static let ingredientError = IngredientError()
    
    // MARK: - Corrupted Data
    static var ingredientBadData: Data? {
        let bundle = Bundle(for: IngredientsResponseDataFake.self)
        let url = bundle.url(forResource: "EdamamFoodBadData", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            return data
        } catch {
            return Data()
        }
    }
    
    // MARK: - Correct Data
    static var ingredientCorrectData: Data? {
        let bundle = Bundle(for: IngredientsResponseDataFake.self)
        let url = bundle.url(forResource: "EdamamFoodCorrectData", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            return data
        } catch {
            return Data()
        }
    }
    
    // MARK: - Incorrect Data
    static let ingredientIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://fake.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://fake.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
}
