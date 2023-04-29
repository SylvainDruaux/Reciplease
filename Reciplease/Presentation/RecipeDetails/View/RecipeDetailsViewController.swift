//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var recipeDetailsTableView: UITableView!
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yieldLabel: UILabel!
    @IBOutlet private var totalTimeLabel: UILabel!
    @IBOutlet private var favoriteBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    private let favoriteRecipeViewModel = FavoriteRecipeViewModel()
    private let recipeViewModel = RecipeViewModel()
    var recipe: Recipe?
    private var ingredientLines: [String]?
    private lazy var totalTimeFontSize = totalTimeLabel.font.pointSize
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsTableView.dataSource = self
        recipeDetailsTableView.delegate = self
        
        favoriteRecipeViewModel.isFavorite.bind { [weak self] success in
            if success {
                self?.favoriteBarButtonItem.image = UIImage(systemName: "star.fill")
            } else {
                self?.favoriteBarButtonItem.image = UIImage(systemName: "star")
            }
        }
        
        recipeViewModel.imageData.bind { [weak self] imageData in
            // No DispatchQueue.main.async, RecipeViewModel is @MainActor
            guard let imageData else { return }
            guard let imageView = self?.recipeImageView else { return }
            imageView.image = UIImage(data: imageData)
            imageView.contentMode = .scaleAspectFill
        }
        
        // Accessibility
        favoriteBarButtonItem.accessibilityLabel = NSLocalizedString("favoriteBarButtonItem_Label", comment: "Favorites button label")
        favoriteBarButtonItem.accessibilityHint = NSLocalizedString("favoriteBarButtonItem_Hint", comment: "Favorites button hint")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure(with: recipe)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Bug fix: the ImageView doesn't take the full width of the screen despite the constraints.
        recipeImageView.setNeedsLayout()
        recipeImageView.layoutIfNeeded()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeWebPageVC = segue.destination as? RecipeWebPageViewController {
            guard let recipe else { return }
            recipeWebPageVC.recipeURL = URL(string: recipe.sourceUrl)
        }
    }
    
    // MARK: - View
    private func configure(with recipe: Recipe?) {
        guard let recipe else { return }
        favoriteRecipeViewModel.isFavorite(recipe: recipe)
        recipeViewModel.fetchImage(with: recipe.imageUrl)
        titleLabel.text = recipe.label
        let yieldLabelText = recipe.yield.isZero ? "N/A" : recipe.yield.decimalNotation
        yieldLabel.text = yieldLabelText
        let totalTimeText = recipe.totalTime.isZero ? "N/A" : recipe.totalTime.timeNotation
        totalTimeLabel.text = totalTimeText
        if recipe.totalTime > 60 {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize * 0.8)
        } else {
            totalTimeLabel.font = totalTimeLabel.font.withSize(totalTimeFontSize)
        }
        ingredientLines = recipe.ingredientLines
        
        // Accessibility
        let yieldTitle = NSLocalizedString("yieldLabel_Title", comment: "Yield")
        yieldLabel.accessibilityLabel = "\(yieldTitle): \(yieldLabelText)"
        yieldLabel.accessibilityHint = yieldTitle
        
        let totalTimeTitle = NSLocalizedString("totalTimeLabel_Title", comment: "Total time")
        totalTimeLabel.accessibilityLabel = "\(totalTimeTitle): \(totalTimeText)"
        totalTimeLabel.accessibilityHint = totalTimeTitle
    }
    
    // MARK: - Actions
    @IBAction private func favoriteButton(_ sender: UIBarButtonItem) {
        guard let recipe else { return }
        favoriteRecipeViewModel.userDidTapFavoriteButton(with: recipe)
    }
    
    @IBAction private func showDirections(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWebPage", sender: nil)
    }
}

// MARK: - TableView DataSource & Delegate
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
