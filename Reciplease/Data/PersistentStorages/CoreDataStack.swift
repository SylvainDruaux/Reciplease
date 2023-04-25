//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

final class CoreDataStack: CoreDataStackProtocol {
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer
    
    init(_ storageType: StorageType = .persistent) {
        self.persistentContainer = NSPersistentContainer(name: "CoreDataStorage")
        if storageType == .inMemory {
            self.persistentContainer.newBackgroundContext()
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        
        self.persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
