//
//  StorageError.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/04/2023.
//

import Foundation

enum StorageError: Error {
    case dataSourceError, createError, deleteError, fetchError
}
