//
//  FavoriteRecipeDataSource.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/04/2023.
//

import Foundation
import CoreData

final class FavoriteRecipeDataSource: FavoriteRecipeDataSourceProtocol {    
    private let coreDataStack: CoreDataStack
    private let context = CoreDataStack.shared.viewContext

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func create(recipe: Recipe) async throws {
        let recipeEntity = RecipeEntity(context: context)
        recipeEntity.id = recipe.id
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
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func getAll() async throws -> [RecipeEntity] {
        let request = RecipeEntity.fetchRequest()
        return try context.fetch(request)
    }
    
    func delete(_ id: UUID) async throws {
        let recipeEntity = try getEntityById(id)!
        context.delete(recipeEntity)
        do {
            try context.save()
        } catch {
            context.rollback()
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    private func getEntityById(_ id: UUID) throws -> RecipeEntity? {
        let request = RecipeEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let recipeEntity = try context.fetch(request)[0]
        return recipeEntity
    }
}
