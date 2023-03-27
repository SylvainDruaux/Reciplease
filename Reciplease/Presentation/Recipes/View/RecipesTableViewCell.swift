//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var ingredientNamesLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yieldLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: [String]) {
        recipeImage.image = UIImage()
        ingredientNamesLabel.text = ""
        titleLabel.text = ""
        yieldLabel.text = ""
        totalTimeLabel.text = ""
    }
}
