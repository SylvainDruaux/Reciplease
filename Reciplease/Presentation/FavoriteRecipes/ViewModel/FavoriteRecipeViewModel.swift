//
//  FavoriteRecipeViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import Foundation

@MainActor
final class FavoriteRecipeViewModel {
    let recipes: Box<[Recipe]?> = Box(nil)
    let isFavorite: Box<Bool> = Box(false)
    var errorDescription: Box<String> = Box("")
    
    private let saveFavoriteRecipesUseCase: SaveFavoriteRecipesUseCaseProtocol
    private let fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseProtocol
    private let removeFavoriteRecipesUseCase: RemoveFavoriteRecipesUseCaseProtocol
    
    init(saveFavoriteRecipesUseCase: SaveFavoriteRecipesUseCaseProtocol = SaveFavoriteRecipesUseCase(),
         fetchFavoriteRecipesUseCase: FetchFavoriteRecipesUseCaseProtocol = FetchFavoriteRecipesUseCase(),
         removeFavoriteRecipesUseCase: RemoveFavoriteRecipesUseCaseProtocol = RemoveFavoriteRecipesUseCase()
    ) {
        self.saveFavoriteRecipesUseCase = saveFavoriteRecipesUseCase
        self.fetchFavoriteRecipesUseCase = fetchFavoriteRecipesUseCase
        self.removeFavoriteRecipesUseCase = removeFavoriteRecipesUseCase
    }
    
    func userDidTapFavoriteButton(with recipe: Recipe) {
        Task {
            do {
                let favoriteRecipes = try await fetchFavoriteRecipesUseCase.execute()
                if !favoriteRecipes.contains(recipe) {
                    try await saveFavoriteRecipesUseCase.execute(recipe)
                    self.isFavorite.value = true
                } else {
                    try await removeFavoriteRecipesUseCase.execute(recipe.id)
                    self.isFavorite.value = false
                }
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
    
    func userDidTapFavoritesNavItem() {
        Task {
            do {
                let favoriteRecipes = try await fetchFavoriteRecipesUseCase.execute()
                self.recipes.value = favoriteRecipes
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
    
    func isFavorite(recipe: Recipe) {
        Task {
            do {
                let favoriteRecipes = try await fetchFavoriteRecipesUseCase.execute()
                if favoriteRecipes.contains(recipe) {
                    self.isFavorite.value = true
                } else {
                    self.isFavorite.value = false
                }
            } catch {
                self.errorDescription.value = error.localizedDescription
            }
        }
    }
}
