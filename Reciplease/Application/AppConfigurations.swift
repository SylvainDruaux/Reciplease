//
//  AppConfigurations.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/03/2023.
//

import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    private func getValue(forKey key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
             fatalError("Missing \(key)")
         }
        return value
    }
    
    lazy var recipeAppId: String = {
        return getValue(forKey: "RECIPE_SEARCH_APP_ID")
    }()
    lazy var recipeApiKey: String = {
        return getValue(forKey: "RECIPE_SEARCH_API_KEY")
    }()
    lazy var foodAppId: String = {
        return getValue(forKey: "FOOD_DATABASE_APP_ID")
    }()
    lazy var foodApiKey: String = {
        return getValue(forKey: "FOOD_DATABASE_API_KEY")
    }()
    
    lazy var recipeBaseURL: String = {
        return getValue(forKey: "RECIPE_SEARCH_BASE_URL")
    }()
    lazy var foodBaseURL: String = {
        return getValue(forKey: "FOOD_DATABASE_BASE_URL")
    }()
}
