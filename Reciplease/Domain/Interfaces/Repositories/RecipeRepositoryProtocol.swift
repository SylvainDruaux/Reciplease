//
//  RecipeRepositoryProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func getRecipes(query: String, completion: @escaping(Result<RecipeResponseDTO, DataError>) -> Void)
    func getImage(url: String, completion: @escaping(Result<Data, DataError>) -> Void)
}
