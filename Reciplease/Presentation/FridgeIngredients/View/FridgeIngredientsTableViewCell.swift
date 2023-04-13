//
//  FridgeIngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class FridgeIngredientsTableViewCell: UITableViewCell {
    @IBOutlet private var fridgeIngredientLabel: UILabel!
    
    func configure(with model: String) {
        fridgeIngredientLabel.text = "- \(model.capitalized)"
    }
}
