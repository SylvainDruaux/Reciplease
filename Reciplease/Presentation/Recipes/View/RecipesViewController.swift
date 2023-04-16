//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    @IBOutlet private var recipesTableView: UITableView!
    
    private let recipeViewModel = RecipeViewModel()
    private var tableViewHeight: CGFloat?
    
    private var detailedRecipe: Recipe?
    private var detailedRecipeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        
        recipeViewModel.recipes.bind { [weak self] _ in
            // No DispatchQueue.main.async, RecipeViewModel is @MainActor
            self?.recipesTableView.reloadData()
        }
        recipeViewModel.fetchRecipes()
        recipesTableView.tableFooterView = createActivityIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight = recipesTableView.frame.height
    }
    
    func setQuery(with fridgeIngredients: String) {
        recipeViewModel.ingredients = fridgeIngredients
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = detailedRecipe
            recipeDetailsVC.recipeImage = detailedRecipeImage
        }
    }
    
    func createActivityIndicator() -> UIView {
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 180)
        let footerView = UIView(frame: frame)
        let indicator = UIActivityIndicatorView()
        indicator.center = footerView.center
        footerView.addSubview(indicator)
        indicator.startAnimating()
        return footerView
    }
}

// MARK: - TableView DataSource & Delegate
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeViewModel.recipes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell", for: indexPath
        ) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        let model = recipeViewModel.recipes.value[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailedRecipe = recipeViewModel.recipes.value[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipesTableViewCell else { return }
        detailedRecipeImage = cell.recipeImageView.image
        performSegue(withIdentifier: "goToRecipeDetails", sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableViewHeight else { return 180 }
        let cellHeight = tableViewHeight / 3.5
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recipeViewModel.recipes.value.count - 1 {
            if !recipeViewModel.nextRecipesLink.isEmpty {
                recipeViewModel.fetchNextRecipes()
            } else {
                recipesTableView.tableFooterView = nil
            }
        }
    }
}
