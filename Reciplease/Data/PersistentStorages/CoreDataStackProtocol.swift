//
//  CoreDataStackProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 20/04/2023.
//

import CoreData

protocol CoreDataStackProtocol {
    var persistentContainer: NSPersistentContainer { get }
}
