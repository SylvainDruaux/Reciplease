//
//  RecipeDetailsTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class RecipeDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var hyphenLabel: UILabel!
    @IBOutlet var recipeIngredientLine: UILabel!
    
    // MARK: - View
    func configure(with model: String) {
        recipeIngredientLine.text = model.capitalizedSentence
        let numberOfLines = recipeIngredientLine.lines
        var hyphenText = "- "
        if recipeIngredientLine.lines > 1 {
            for _ in 2...numberOfLines {
                hyphenText += "\n"
            }
        }
        hyphenLabel.text = hyphenText
    }
}
