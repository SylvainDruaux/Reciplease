//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation

@MainActor
final class RecipeViewModel {
    let recipes: Box<RecipeResponseDTO?> = Box(nil)
    let imageData: Box<Data?> = Box(nil)
    let recipeRepository: RecipeRepositoryProtocol
    
    var recipesData: [Recipe] = []
    var ingredients: String = ""
    
    init(recipeRepository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func fetchRecipes() {
        recipeRepository.getRecipes(query: ingredients) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipes):
                self.recipes.value = recipes
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNextRecipes(from url: String) {
        recipeRepository.getNextRecipes(url: url) { [weak self] result in
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
        recipeRepository.getImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageData):
                self.imageData.value = imageData
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func userDidTapFavoriteButton(with recipe: Recipe) {
        Task {
            do {
                let favoriteRecipes = try await recipeRepository.getFavoriteRecipes()
                if let favoriteRecipes, !favoriteRecipes.contains(where: {
                    $0.id == recipe.id }
                ) {
                    try await recipeRepository.createFavoriteRecipe(recipe)
                    print("Recipe created: \(recipe.label)")
                } else {
                    try await recipeRepository.deleteFavoriteRecipe(recipe.id)
                    print("Recipe deleted: \(recipe.label)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
