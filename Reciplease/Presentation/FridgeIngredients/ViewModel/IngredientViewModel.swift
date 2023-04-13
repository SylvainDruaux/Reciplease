//
//  IngredientViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 27/03/2023.
//

import Foundation

@MainActor
final class IngredientViewModel {
    let ingredients: Box<IngredientResponse> = Box([])
    let fridgeIngredients: Box<FridgeIngredients> = Box([])
    
    var fridgeIngredientsData: FridgeIngredients = []
    
    let ingredientRepository: IngredientRepositoryProtocol
    private let fridgeIngredientRepository = FridgeIngredientRepository()
    
    init(ingredientRepository: IngredientRepositoryProtocol = IngredientRepository()) {
        self.ingredientRepository = ingredientRepository
    }
    
    func fetchIngredients(startingWith query: String) {
        ingredientRepository.getIngredients(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let ingredients):
                self.ingredients.value = ingredients
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func userDidTapSearchButton() {
        Task {
            do {
                try await fridgeIngredientRepository.deleteFridgeIngredients()
                try await fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredientsData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDidLoadPreviousList() {
        Task {
            do {
                if let fridgeIngredients = try await fridgeIngredientRepository.getFridgeIngredients() {
                    self.fridgeIngredients.value = fridgeIngredients
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
