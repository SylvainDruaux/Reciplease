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
        try await context.perform { [self] in
            _ = RecipeEntity(recipe: recipe, in: context)
            try context.save()
        }
    }
    
    func getAll() async throws -> [RecipeEntity] {
        try await context.perform { [self] in
            let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            return try context.fetch(request)
        }
    }
    
    func delete(_ id: String) async throws {
        guard let recipeEntity = try await getEntityById(id) else { return }
        try await context.perform { [self] in
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
        try await context.perform { [self] in
            let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", id)
            return try context.fetch(request).first
        }
    }
}
