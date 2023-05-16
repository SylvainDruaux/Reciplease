//
//  RecipeEntity+MappingTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 27/04/2023.
//

import XCTest
import CoreData
@testable import Reciplease

class RecipeEntityMappingTests: XCTestCase {
    func test_toDomain() {
        let coreDataStack = CoreDataStack(.inMemory)
        let context = coreDataStack.persistentContainer.viewContext
        let recipe = Recipe(
            label: "My recipe",
            imageUrl: "imageUrl",
            sourceUrl: "sourceUrl",
            yield: 4,
            ingredientLines: [""],
            ingredients: [""],
            totalTime: 30
        )
        let recipeEntity = RecipeEntity(recipe: recipe, in: context)
        
        let recipeFromCoreDataEntity = recipeEntity.toDomain()
        
        XCTAssertEqual(recipeFromCoreDataEntity.id, "MyrecipesourceUrl")
        XCTAssertEqual(recipeFromCoreDataEntity.label, "My recipe")
        XCTAssertEqual(recipeFromCoreDataEntity.imageUrl, "imageUrl")
        XCTAssertEqual(recipeFromCoreDataEntity.sourceUrl, "sourceUrl")
        XCTAssertEqual(recipeFromCoreDataEntity.yield, 4)
        XCTAssertEqual(recipeFromCoreDataEntity.ingredientLines, [""])
        XCTAssertEqual(recipeFromCoreDataEntity.ingredients, [""])
        XCTAssertEqual(recipeFromCoreDataEntity.totalTime, 30)
    }
}
