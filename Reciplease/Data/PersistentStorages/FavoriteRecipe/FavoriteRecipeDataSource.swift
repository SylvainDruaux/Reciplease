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
    private let context: NSManagedObjectContext

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
    }
    
    func create(recipe: Recipe) async throws {
        try context.performAndWait {
            do {
                _ = RecipeEntity(recipe: recipe, in: context)
                try context.save()
            } catch {
                throw error
            }
        }
    }
    
    func getAll() async throws -> [RecipeEntity] {
        try context.performAndWait {
            do {
                let request = RecipeEntity.fetchRequest()
                return try context.fetch(request)
            } catch {
                throw error
            }
        }
    }
    
    func delete(_ id: String) async throws {
        guard let recipeEntity = try await getEntityById(id) else { return }
        try context.performAndWait {
            do {
                context.delete(recipeEntity)
                try context.save()
            } catch {
                context.rollback()
                throw error
            }
        }
    }
    
    private func getEntityById(_ id: String) async throws -> RecipeEntity? {
        try context.performAndWait {
            do {
                let request = RecipeEntity.fetchRequest()
                request.fetchLimit = 1
                request.predicate = NSPredicate(format: "id = %@", id)
                let recipeEntity = try context.fetch(request).first
                return recipeEntity
            } catch {
                throw error
            }
        }
    }
}
