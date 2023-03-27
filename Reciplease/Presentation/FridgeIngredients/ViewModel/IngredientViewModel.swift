//
//  IngredientViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 27/03/2023.
//

import Foundation

class IngredientViewModel {
    let ingredients: Box<IngredientResponse> = Box([])
    
    func fetchIngredients(startingWith query: String) {
        IngredientViewService.shared.getIngredients(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let ingredients):
                self.ingredients.value = ingredients
            case .failure(let error):
                print(error)
            }
        }
    }
}
