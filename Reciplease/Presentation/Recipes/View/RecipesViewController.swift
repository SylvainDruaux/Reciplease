//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var recipesTableView: UITableView!
    
    // MARK: - Properties
    private let recipeViewModel = RecipeViewModel()
    private var tableViewHeight: CGFloat?
    private var detailedRecipe: Recipe?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        
        recipeViewModel.errorDescription.bind { [weak self] error in
            if !error.isEmpty {
                self?.presentAlert(title: "Error", message: error)
            }
        }
        
        recipeViewModel.recipes.bind { [weak self] _ in
            // No DispatchQueue.main.async, RecipeViewModel is @MainActor
            self?.recipesTableView.reloadData()
        }
        recipesTableView.tableFooterView = createActivityIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight = recipesTableView.frame.height
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = detailedRecipe
        }
    }
}

// MARK: - View
extension RecipesViewController {
    func update(with fridgeIngredients: String) {
        recipeViewModel.fetchRecipes(fridgeIngredients)
    }
    
    private func createActivityIndicator() -> UIView {
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
        ) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let model = recipeViewModel.recipes.value[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailedRecipe = recipeViewModel.recipes.value[indexPath.row]
        performSegue(withIdentifier: "goToRecipeDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableViewHeight else { return 180 }
        let screenHeight = UIScreen.main.bounds.height
        var cellHeight: CGFloat
        if screenHeight <= 780 {
            cellHeight = tableViewHeight / 2.5
        } else {
            cellHeight = tableViewHeight / 3.5
        }
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
