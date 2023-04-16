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
    
    private let searchIngredientsUseCase: SearchIngredientsUseCaseProtocol
    private let manageFridgeIngredientsUseCase: ManageFridgeIngredientsUseCaseProtocol
    
    init(searchIngredientsUseCase: SearchIngredientsUseCaseProtocol = SearchIngredientsUseCase(),
         manageFridgeIngredientsUseCase: ManageFridgeIngredientsUseCaseProtocol = ManageFridgeIngredientsUseCase()
    ) {
        self.searchIngredientsUseCase = searchIngredientsUseCase
        self.manageFridgeIngredientsUseCase = manageFridgeIngredientsUseCase
    }
    
    func fetchIngredients(startingWith query: String) {
        Task {
            do {
                let ingredients = try await searchIngredientsUseCase.getIngredients(query: query)
                self.ingredients.value = ingredients
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDidTapClearList() {
        guard !fridgeIngredients.value.isEmpty else { return }
        fridgeIngredients.value.removeAll()
    }
    
    func userDidTapSearchButton() {
        Task {
            do {
                try await manageFridgeIngredientsUseCase.deleteFridgeIngredients()
                try await manageFridgeIngredientsUseCase.saveFridgeIngredients(fridgeIngredients.value)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDidLoadPreviousList() {
        Task {
            do {
                let fridgeIngredients = try await manageFridgeIngredientsUseCase.getFridgeIngredients()
                self.fridgeIngredients.value = fridgeIngredients
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
