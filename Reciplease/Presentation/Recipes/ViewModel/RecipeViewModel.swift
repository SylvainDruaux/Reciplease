//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

@MainActor
final class RecipeViewModel {
    let recipes: Box<[Recipe]> = Box([])
    let imageData: Box<Data?> = Box(nil)
    var errorDescription: Box<String> = Box("")
    var nextRecipesLink: String = ""
    
    private let fetchRecipesPageUseCase: FetchRecipesPageUseCaseProtocol
    private let fetchNextRecipesPageUseCase: FetchNextRecipesPageUseCaseProtocol
    private let fetchRecipeImageUseCase: FetchRecipeImageUseCaseProtocol
    
    init(fetchRecipesPageUseCase: FetchRecipesPageUseCaseProtocol = FetchRecipesPageUseCase(),
         fetchNextRecipesPageUseCase: FetchNextRecipesPageUseCaseProtocol = FetchNextRecipesPageUseCase(),
         fetchRecipeImageUseCase: FetchRecipeImageUseCaseProtocol = FetchRecipeImageUseCase()
    ) {
        self.fetchRecipesPageUseCase = fetchRecipesPageUseCase
        self.fetchNextRecipesPageUseCase = fetchNextRecipesPageUseCase
        self.fetchRecipeImageUseCase = fetchRecipeImageUseCase
    }
    
    func fetchRecipes(_ ingredients: String) {
        Task {
            do {
                let recipesPage = try await fetchRecipesPageUseCase.execute(query: ingredients)
                self.recipes.value = recipesPage.recipes
                self.nextRecipesLink = recipesPage.nextPage ?? ""
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
    
    func fetchNextRecipes() {
        Task {
            do {
                let recipesPage = try await fetchNextRecipesPageUseCase.execute(url: nextRecipesLink)
                self.recipes.value += recipesPage.recipes
                self.nextRecipesLink = recipesPage.nextPage ?? ""
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
    
    func fetchImage(with url: String) {
        Task {
            do {
                let imageData = try await fetchRecipeImageUseCase.execute(url: url)
                self.imageData.value = imageData
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
}
