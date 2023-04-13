//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {

    @IBOutlet private var recipeDetailsTableView: UITableView!
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yieldLabel: UILabel!
    @IBOutlet private var totalTimeLabel: UILabel!
    
    private let recipeViewModel = RecipeViewModel()
    var recipe: Recipe?
    var recipeImage: UIImage?
    private var ingredientLines: [String]?
    private var recipeURL: URL?
    private lazy var totalTimeFontSize = totalTimeLabel.font.pointSize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.delegate = self
        
        configureImage(with: recipeImage)
        configure(with: recipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeWebPageVC = segue.destination as? RecipeWebPageViewController {
            recipeWebPageVC.recipeURL = recipeURL
        }
    }
    
    private func configure(with recipe: Recipe?) {
        guard let recipe else { return }
        titleLabel.text = recipe.label
        yieldLabel.text = recipe.yield.isZero ? "N/A" : recipe.yield.decimalNotation
        totalTimeLabel.text = recipe.totalTime.isZero ? "N/A" : recipe.totalTime.timeNotation
        if recipe.totalTime > 60 {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize * 0.8)
        } else {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize)
        }
        ingredientLines = recipe.ingredientLines
    }
    
    private func configureImage(with image: UIImage?) {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.image = recipeImage
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        guard let recipe else { return }
        recipeViewModel.userDidTapFavoriteButton(with: recipe)
        if let itemImage = sender.image, itemImage.accessibilityIdentifier == "star" {
            sender.image = UIImage(systemName: "star.fill")
        } else {
            sender.image = UIImage(systemName: "star")
        }
    }
    
    @IBAction func showDirections(_ sender: UIButton) {
        guard let recipe else { return }
        recipeURL = URL(string: recipe.sourceUrl)
        performSegue(withIdentifier: "goToWebPage", sender: nil)
    }
}

extension RecipeDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeDetailCell", for: indexPath
        ) as? RecipeDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        guard let model = ingredientLines?[indexPath.row] else { return cell }
        cell.configure(with: model)
        return cell
    }
}
