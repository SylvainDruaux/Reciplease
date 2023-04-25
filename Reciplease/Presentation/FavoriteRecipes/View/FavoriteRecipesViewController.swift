//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/04/2023.
//

import UIKit

final class FavoriteRecipesViewController: UIViewController {

    @IBOutlet private var favoriteRecipesTableView: UITableView!
    
    private let favoriteRecipeViewModel = FavoriteRecipeViewModel()
    private var tableViewHeight: CGFloat?
    
    private var detailedRecipe: Recipe?
    private var detailedRecipeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteRecipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        favoriteRecipesTableView.dataSource = self
        favoriteRecipesTableView.delegate = self
        
        favoriteRecipeViewModel.errorDescription.bind { [weak self] error in
            if !error.isEmpty {
                self?.presentAlert(error)
            }
        }
        
        favoriteRecipeViewModel.recipes.bind { [weak self] _ in
            // No DispatchQueue.main.async, RecipeViewModel is @MainActor
            self?.favoriteRecipesTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipeViewModel.userDidTapFavoritesNavItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight = favoriteRecipesTableView.frame.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = detailedRecipe
            recipeDetailsVC.recipeImage = detailedRecipeImage
            recipeDetailsVC.favoriteBarButtonItem.image = UIImage(systemName: "star.fill")
        }
    }
}

// MARK: - TableView DataSource & Delegate
extension FavoriteRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipeViewModel.recipes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell", for: indexPath
        ) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let model = favoriteRecipeViewModel.recipes.value[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailedRecipe = favoriteRecipeViewModel.recipes.value[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else { return }
        detailedRecipeImage = cell.recipeImageView.image
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
}
