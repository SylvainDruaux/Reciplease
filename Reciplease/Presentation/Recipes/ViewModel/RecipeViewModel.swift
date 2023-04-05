//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

final class RecipeViewModel {
    let recipes: Box<RecipeResponseDTO?> = Box(nil)
    let imageData: Box<Data?> = Box(nil)
    
    func fetchRecipes(with query: String) {
        RecipeRepository.shared.getRecipes(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipes):
                self.recipes.value = recipes
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(with url: String) {
        RecipeRepository.shared.getImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageData):
                self.imageData.value = imageData
            case .failure(let error):
                print(error)
            }
        }
    }
}
