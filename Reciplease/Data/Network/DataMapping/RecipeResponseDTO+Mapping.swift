//
//  RecipeResponseDTO+Mapping.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation

// MARK: - Data Transfer Object
struct RecipeResponseDTO: Decodable {
    let count: Int
    let links: LinksDTO?
    let hits: [HitDTO]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case links = "_links"
        case hits
    }
}

extension RecipeResponseDTO {
    struct LinksDTO: Decodable {
        let next: NextDTO?
    }

    struct NextDTO: Decodable {
        let href: String
    }

    struct HitDTO: Decodable {
        let recipe: RecipeDTO
    }

    struct RecipeDTO: Decodable {
        let label: String
        let images: ImagesDTO
        let url: String // Website for Directions
        let yield: Float
        let ingredientLines: [String]
        let ingredients: [IngredientDTO]
        let totalTime: Double
    }
    
    struct IngredientDTO: Decodable {
        let food: String
    }
    
    struct ImagesDTO: Decodable {
        let regular: RegularDTO
        let large: LargeDTO?
        
        private enum CodingKeys: String, CodingKey {
            case regular = "REGULAR"
            case large = "LARGE"
        }
    }
    
    struct RegularDTO: Decodable {
        let url: String
    }
    
    struct LargeDTO: Decodable {
        let url: String
    }
}

// MARK: - Mappings to Domain
extension RecipeResponseDTO {
    func toDomain() -> RecipesPage {
        let nextPage = links?.next?.href
        return .init(nextPage: nextPage,
                     recipes: hits.map { $0.toDomain() }
        )
    }
}

extension RecipeResponseDTO.HitDTO {
    func toDomain() -> Recipe {
        let imageUrl: String
        let imageRegularUrl = recipe.images.regular.url
        if let imageLargeUrl = recipe.images.large?.url {
            imageUrl = imageLargeUrl
        } else {
            imageUrl = imageRegularUrl
        }
        
        return .init(id: UUID(),
                     label: recipe.label,
                     imageUrl: imageUrl,
                     sourceUrl: recipe.url,
                     yield: recipe.yield,
                     ingredientLines: recipe.ingredientLines,
                     ingredients: recipe.ingredients.map { $0.food },
                     totalTime: recipe.totalTime
        )
    }
}
