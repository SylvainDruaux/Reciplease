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
    var nextRecipesLink: String = ""
    
    private let searchRecipesUseCase: SearchRecipesUseCaseProtocol
    private let manageFavoriteRecipesUseCase: ManageFavoriteRecipesUseCaseProtocol
    
    var ingredients: String = ""
    
    init(searchRecipesUseCase: SearchRecipesUseCaseProtocol = SearchRecipesUseCase(),
         manageFavoriteRecipesUseCase: ManageFavoriteRecipesUseCaseProtocol = ManageFavoriteRecipesUseCase()
    ) {
        self.searchRecipesUseCase = searchRecipesUseCase
        self.manageFavoriteRecipesUseCase = manageFavoriteRecipesUseCase
    }
    
    func fetchRecipes() {
        Task {
            do {
                let recipeResponse = try await searchRecipesUseCase.getRecipes(query: ingredients)
                self.recipes.value = recipeResponse.toDomain().recipes
                self.nextRecipesLink = recipeResponse.toDomain().nextPage ?? ""
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextRecipes() {
        Task {
            do {
                let recipeResponse = try await searchRecipesUseCase.getNextRecipes(url: nextRecipesLink)
                self.recipes.value += recipeResponse.toDomain().recipes
                self.nextRecipesLink = recipeResponse.toDomain().nextPage ?? ""
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(with url: String) {
        Task {
            do {
                let imageData = try await searchRecipesUseCase.getImage(url: url)
                self.imageData.value = imageData
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDidTapFavoriteButton(with recipe: Recipe) {
        Task {
            do {
                let favoriteRecipes = try await manageFavoriteRecipesUseCase.getFavoriteRecipes().map { $0.toDomain() }
                if !favoriteRecipes.contains(where: { $0.id == recipe.id }) {
                    try await manageFavoriteRecipesUseCase.createFavoriteRecipe(recipe)
                    print("Recipe created: \(recipe.label)")
                } else {
                    try await manageFavoriteRecipesUseCase.deleteFavoriteRecipe(recipe.id)
                    print("Recipe deleted: \(recipe.label)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func userDidTapFavoritesNavItem() {
        Task {
            do {
                let favoriteRecipes = try await manageFavoriteRecipesUseCase.getFavoriteRecipes().map { $0.toDomain() }
                self.recipes.value = favoriteRecipes
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
