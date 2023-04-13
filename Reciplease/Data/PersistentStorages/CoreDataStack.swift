//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    var viewContext: NSManagedObjectContext { // can't be NSManagedObjectContextProtocol
        return CoreDataStack.shared.persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol { }
