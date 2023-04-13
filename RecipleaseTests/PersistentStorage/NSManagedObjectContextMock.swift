//
//  NSManagedObjectContextMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 13/04/2023.
//

import Foundation
import CoreData
@testable import Reciplease

enum ErrorMock: Error {
    case dummy
}

class NSManagedObjectContextMock: NSManagedObjectContextProtocol {
    
    let shouldThrowFetch: Bool
    let shouldThrowSave: Bool
    let shouldThrowDelete: Bool
    let shouldThrowRollback: Bool
    
    init(shouldThrowFetch: Bool, shouldThrowSave: Bool, shouldThrowDelete: Bool, shouldThrowRollback: Bool) {
        self.shouldThrowFetch = shouldThrowFetch
        self.shouldThrowSave = shouldThrowSave
        self.shouldThrowDelete = shouldThrowDelete
        self.shouldThrowRollback = shouldThrowRollback
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] where T: NSFetchRequestResult {
        if shouldThrowFetch {
            throw ErrorMock.dummy
        }
        return .init()
    }
    
    func save() throws {
        if shouldThrowSave {
            throw ErrorMock.dummy
        }
    }
    
    func delete(_ object: NSManagedObject) {
        if shouldThrowDelete { }
    }
    
    func rollback() {
        if shouldThrowRollback { }
    }
}
