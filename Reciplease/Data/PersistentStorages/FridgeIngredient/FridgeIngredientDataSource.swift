//
//  FridgeIngredientDataSource.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation
import CoreData

final class FridgeIngredientDataSource: FridgeIngredientDataSourceProtocol {
    private let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
    }
    
    func save(fridgeIngredients: FridgeIngredients) async throws {
        try await deleteAll()
        try context.performAndWait {
            do {
                for (index, ingredient) in fridgeIngredients.enumerated() {
                    let fridgeIngredientEntity = FridgeIngredientEntity(context: context)
                    fridgeIngredientEntity.name = ingredient
                    fridgeIngredientEntity.index = Int16(index)
                }
                try context.save()
            } catch {
                throw error
            }
        }
    }
    
    func getAll() async throws -> FridgeIngredients {
        try context.performAndWait {
            do {
                let request = FridgeIngredientEntity.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
                request.sortDescriptors = [sortDescriptor]
                let objects = try context.fetch(request)
                let fridgeIngredients = objects.map { $0.name }.compactMap { $0 }
                return fridgeIngredients
            } catch {
                throw error
            }
        }
    }
    
    func deleteAll() async throws {
        try context.performAndWait {
            do {
                let request = FridgeIngredientEntity.fetchRequest()
                let ingredients = try context.fetch(request)
                if !ingredients.isEmpty {
                    for ingredient in ingredients {
                        context.delete(ingredient)
                    }
                    try context.save()
                }
            } catch {
                throw error
            }
        }
    }
}
