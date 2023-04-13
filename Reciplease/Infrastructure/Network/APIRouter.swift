//
//  APIRouter.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
}

public enum APIRouter: URLRequestConvertible {
    case getIngredients(query: String)
    case getRecipes(query: String)
    case getNextRecipes(url: String)
    case getImage(url: String)
    
    private var urlPath: String {
        switch self {
        case .getIngredients:
            return AppConfiguration.shared.foodBaseURL
        case .getRecipes:
            return AppConfiguration.shared.recipeBaseURL
        case .getNextRecipes(let url):
            return url
        case .getImage(let url):
            return url
        }
    }
    
    private var parameters: Parameters {
        var urlParams = [String: Any]()
        switch self {
        case .getIngredients(let query):
            urlParams["app_id"] = AppConfiguration.shared.foodAppId
            urlParams["app_key"] = AppConfiguration.shared.foodApiKey
//            urlParams["limit"] = 10
            urlParams["q"] = query
            return urlParams
        case .getRecipes(let query):
            urlParams["type"] = "public"
            urlParams["app_id"] = AppConfiguration.shared.recipeAppId
            urlParams["app_key"] = AppConfiguration.shared.recipeApiKey
            urlParams["q"] = query
            return urlParams
        case .getNextRecipes:
            // Parameters are embedded in the URL.
            return urlParams
        case .getImage:
            // Parameters are embedded in the URL.
            return urlParams
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try urlPath.asURL()
        let urlRequest = URLRequest(url: url)
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
