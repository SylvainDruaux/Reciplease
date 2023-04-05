//
//  FavoriteRecipesStorage.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/04/2023.
//

import Foundation
import CoreData

final class FavoriteRecipesStorage: FavoriteRecipesStorageProtocol {

    private let coreDataStack: CoreDataStack
    private let context = CoreDataStack.shared.viewContext

    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    func saveRecipe(_ recipe: Recipe) {
        let recipeEntity = RecipeEntity(context: context)
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.ingredientLines = recipe.ingredientLines
        recipeEntity.ingredients = recipe.ingredients
        recipeEntity.label = recipe.label
        recipeEntity.sourceUrl = recipe.sourceUrl
        recipeEntity.totalTime = recipe.totalTime
        recipeEntity.yield = recipe.yield
        do {
            try context.save()
        } catch {
            print("Error saving recipe: \(error)")
        }
    }
    
    func getFavoriteRecipes() -> [RecipeEntity]? {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let recipes = try context.fetch(request)
            return recipes
        } catch {
            print("Error fetching recipe(s): \(error)")
            return nil
        }
    }
    
    private func deleteFavoriteRecipe(_ recipe: Recipe) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate.init(format: "url == %@", recipe.sourceUrl) // Better to use id?
        if let recipes = try? context.fetch(request) {
            for recipe in recipes {
                context.delete(recipe)
            }
        }
    }
    
    func checkDuplicate(for recipe: Recipe) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate.init(format: "url == %@", recipe.sourceUrl)
        guard let recipes = try? context.fetch(request), !recipes.isEmpty else { return false }
        return true
    }
}
