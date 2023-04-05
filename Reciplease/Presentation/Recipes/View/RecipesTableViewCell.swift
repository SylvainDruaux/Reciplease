//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit
import Alamofire

final class RecipesTableViewCell: UITableViewCell {
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet private var ingredientNamesLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yieldLabel: UILabel!
    @IBOutlet private var totalTimeLabel: UILabel!
    
    private let viewModel = RecipeViewModel()
    private lazy var totalTimeFontSize = totalTimeLabel.font.pointSize
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: Recipe) {
        let imageUrl = model.imageUrl
        
        viewModel.imageData.bind { imageData in
            DispatchQueue.main.async {
                guard let imageData else { return }
                guard let imageView = self.recipeImageView else { return }
//                UIView.transition(with: imageView, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                    imageView.image = UIImage(data: imageData)
                    imageView.contentMode = .scaleAspectFill
//                    imageView.alpha = 1
//                })
            }
        }
        viewModel.fetchImage(with: imageUrl)
        
        ingredientNamesLabel.text = model.ingredients.joined(separator: ", ")
        titleLabel.text = model.label
        yieldLabel.text = model.yield.isZero ? "N/A" : model.yield.decimalNotation
        totalTimeLabel.text = model.totalTime.isZero ? "N/A" : model.totalTime.timeNotation
        if model.totalTime > 60 {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize * 0.8)
        } else {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize)
        }
    }
}
