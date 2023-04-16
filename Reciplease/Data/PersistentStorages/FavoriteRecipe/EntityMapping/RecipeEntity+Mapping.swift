//
//  RecipeEntity+Mapping.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 14/04/2023.
//

import Foundation
import CoreData

extension RecipeEntity {
    func toDomain() -> Recipe {
        return .init(id: id ?? UUID(),
                     label: label ?? "",
                     imageUrl: imageUrl ?? "",
                     sourceUrl: sourceUrl ?? "",
                     yield: yield,
                     ingredientLines: ingredientLines ?? [""],
                     ingredients: ingredients ?? [""],
                     totalTime: totalTime
        )
    }
}
