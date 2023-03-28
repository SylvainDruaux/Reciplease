//
//  FridgeIngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class FridgeIngredientsTableViewCell: UITableViewCell {
    @IBOutlet var fridgeIngredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with model: String) {
        fridgeIngredientLabel.text = "- \(model.capitalized)"
    }
}
