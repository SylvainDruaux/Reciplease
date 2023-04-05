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
    private var recipesData: [Recipe]?
    private var tableViewHeight: CGFloat?
    
    var ingredients: String = ""
    
    private var detailedRecipe: Recipe?
    private var detailedRecipeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        
        recipeViewModel.recipes.bind { [weak self] recipeResponse in
            DispatchQueue.main.async {
                guard let recipeResponse else { return }
                let recipes = recipeResponse.toDomain().recipes
                self?.update(with: recipes)
            }
        }
        recipeViewModel.fetchRecipes(with: ingredients)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight = recipesTableView.frame.height
    }
    
    private func update(with recipes: [Recipe]) {
        self.recipesData = recipes
        recipesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = detailedRecipe
            recipeDetailsVC.recipeImage = detailedRecipeImage
        }
    }
}

// MARK: - TableView DataSource & Delegate
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell", for: indexPath
        ) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        guard let model = recipesData?[indexPath.row] else { return cell }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailedRecipe = recipesData?[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipesTableViewCell else { return }
        detailedRecipeImage = cell.recipeImageView.image
        performSegue(withIdentifier: "goToRecipeDetails", sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableViewHeight else { return 180 }
        let cellHeight = tableViewHeight / 3.5
        return cellHeight
    }
}
