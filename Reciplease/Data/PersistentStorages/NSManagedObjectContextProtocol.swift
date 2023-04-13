//
//  NSManagedObjectContextProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 13/04/2023.
//

import Foundation
import CoreData

protocol NSManagedObjectContextProtocol {
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T: NSFetchRequestResult
    func save() throws
    func delete(_ object: NSManagedObject)
    func rollback()
}
