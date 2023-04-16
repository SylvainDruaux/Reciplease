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
    private let context = CoreDataStack.shared.viewContext

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func save(fridgeIngredients: FridgeIngredients) async throws {
        try await deleteAll()
        for (index, ingredient) in fridgeIngredients.enumerated() {
            let fridgeIngredientEntity = FridgeIngredientEntity(context: context)
            fridgeIngredientEntity.name = ingredient
            fridgeIngredientEntity.index = Int16(index)
        }
        saveContext()
    }
    
    func getAll() async throws -> FridgeIngredients {
        let request = FridgeIngredientEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let objects = try context.fetch(request)
        let fridgeIngredients = objects.map { $0.name }.compactMap { $0 }
        return fridgeIngredients
    }
    
    func deleteAll() async throws {
        let request = FridgeIngredientEntity.fetchRequest()
        let ingredients = try context.fetch(request)
        for ingredient in ingredients {
            context.delete(ingredient)
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}
