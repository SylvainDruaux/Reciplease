//
//  FridgeIngredientsStorage.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation
import CoreData

final class FridgeIngredientsStorage: FridgeIngredientsStorageProtocol {

    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    func saveFridgeIngredients(_ fridgeIngredients: FridgeIngredients) {
        deleteAllFridgeIngredients()
        
        let context = CoreDataStack.shared.viewContext
        for (index, ingredient) in fridgeIngredients.enumerated() {
            let fridgeIngredientEntity = FridgeIngredientEntity(context: context)
            fridgeIngredientEntity.name = ingredient
            fridgeIngredientEntity.index = Int16(index)
        }
        do {
            try context.save()
        } catch {
            print("Error saving ingredients: \(error)")
        }
    }
    
    func getFridgeIngredients() -> [FridgeIngredientEntity]? {
        let context = CoreDataStack.shared.viewContext
        let request: NSFetchRequest<FridgeIngredientEntity> = FridgeIngredientEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let ingredients = try context.fetch(request)
            return ingredients
        } catch {
            print("Error fetching ingredients: \(error)")
            return nil
        }
    }
    
    private func deleteAllFridgeIngredients() {
        let context = CoreDataStack.shared.viewContext
        let request: NSFetchRequest<FridgeIngredientEntity> = FridgeIngredientEntity.fetchRequest()
        
        do {
            let ingredients = try context.fetch(request)
            for ingredient in ingredients {
                context.delete(ingredient)
            }
            try context.save()
        } catch {
            print("Error deleting all ingredients: \(error)")
        }
    }
}
