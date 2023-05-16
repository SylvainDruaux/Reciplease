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
    let errorDescription: Box<String> = Box("")
    
    private let searchIngredientsUseCase: SearchIngredientsUseCaseProtocol
    private let saveFridgeIngredientsUseCase: SaveFridgeIngredientsUseCaseProtocol
    private let fetchFridgeIngredientsUseCase: FetchFridgeIngredientsUseCaseProtocol
    private let removeFridgeIngredientsUseCase: RemoveFridgeIngredientsUseCaseProtocol
    
    init(searchIngredientsUseCase: SearchIngredientsUseCaseProtocol = SearchIngredientsUseCase(),
         saveFridgeIngredientsUseCase: SaveFridgeIngredientsUseCaseProtocol = SaveFridgeIngredientsUseCase(),
         fetchFridgeIngredientsUseCase: FetchFridgeIngredientsUseCaseProtocol = FetchFridgeIngredientsUseCase(),
         removeFridgeIngredientsUseCase: RemoveFridgeIngredientsUseCaseProtocol = RemoveFridgeIngredientsUseCase()
    ) {
        self.searchIngredientsUseCase = searchIngredientsUseCase
        self.saveFridgeIngredientsUseCase = saveFridgeIngredientsUseCase
        self.fetchFridgeIngredientsUseCase = fetchFridgeIngredientsUseCase
        self.removeFridgeIngredientsUseCase = removeFridgeIngredientsUseCase
    }
    
    func fetchIngredients(startingWith query: String) {
        Task {
            do {
                let ingredients = try await searchIngredientsUseCase.execute(query: query)
                self.ingredients.value = ingredients
            } catch {
                self.errorDescription.value = error.localizedDescription
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
                try await removeFridgeIngredientsUseCase.execute()
                try await saveFridgeIngredientsUseCase.execute(fridgeIngredients.value)
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
    
    func userDidLoadPreviousList() {
        Task {
            do {
                let fridgeIngredients = try await fetchFridgeIngredientsUseCase.execute()
                self.fridgeIngredients.value = fridgeIngredients
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
}
