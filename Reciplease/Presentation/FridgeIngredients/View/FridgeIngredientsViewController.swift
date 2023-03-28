//
//  FridgeIngredientsViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

final class FridgeIngredientsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var fridgeIngredientsTableView: UITableView!
    @IBOutlet var searchButton: UIButton!
    
    // MARK: - Properties
    private let viewModel = IngredientViewModel()
    private var fridgeIngredientsData: FridgeIngredientModel = []
    private let fridgeIngredientRepository = FridgeIngredientRepository()
    
    private var menuButton: UIBarButtonItem!
    private var menu: UIMenu!
    private let searchController = UISearchController(searchResultsController: ResultsViewController())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initSearchButton()
        fridgeIngredientsTableView.dataSource = self
        fridgeIngredientsTableView.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let recipesVC = segue.destination as? RecipesViewController {
//
//        }
    }
    
    // MARK: - Actions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        fridgeIngredientRepository.saveFridgeIngredients(fridgeIngredientsData)
        performSegue(withIdentifier: "goToRecipes", sender: self)
    }
        
    private func clearList() {
        guard !fridgeIngredientsData.isEmpty else { return }
        fridgeIngredientsData.removeAll()
        fridgeIngredientsTableView.reloadData()
        hideSearchButton()
    }
    
    private func loadPreviousList() {
        self.fridgeIngredientsData.removeAll()
        guard let previousIngredients = self.fridgeIngredientRepository.getFridgeIngredients() else { return }
        self.fridgeIngredientsData = previousIngredients.map { $0.name ?? "" }
        UIView.transition(
            with: self.fridgeIngredientsTableView,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.fridgeIngredientsTableView.reloadData()
        })
        self.showSearchButton()
    }
    
    private func showSearchButton() {
        UIView.animate(withDuration: 1) { self.searchButton.alpha = 1.0 }
        self.searchButton.isEnabled = true
    }
    
    private func hideSearchButton() {
        UIView.animate(withDuration: 1) { self.searchButton.alpha = 0.0 }
        self.searchButton.isEnabled = false
    }
}

// MARK: - View
extension FridgeIngredientsViewController {
    private func initSearchButton() {
        searchButton.alpha = 0.0
        searchButton.isEnabled = false
    }
    
    private func initNavigationBar() {
        initSearchController()
        initMenuButton()
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "textColor")
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .words
        searchController.searchBar.placeholder = "What's in your fridge?"
        searchController.searchBar.tintColor = UIColor(named: "textColor")
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func initMenuButton() {
        menuButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "ellipsis.circle"),
            primaryAction: nil,
            menu: generatePullDownMenu()
        )
    }
    
    private func generatePullDownMenu() -> UIMenu {
        let editItem = UIAction(
            title: "Load previous List",
            image: UIImage(systemName: "restart"),
            handler: { _ in
                if !self.fridgeIngredientsData.isEmpty {
                    self.showAlertWithAction(title: "Warning", message: "If you continue, you will lose the current list.") {
                        self.loadPreviousList()
                    }
                } else {
                    self.loadPreviousList()
                }
            }
        )
        let addItem = UIAction(
            title: "Clear List",
            image: UIImage(systemName: "eraser"),
            handler: { _ in
                self.clearList()
            }
        )
        menu = UIMenu(options: .displayInline, children: [addItem, editItem])
        return menu
    }
}

// MARK: - TableView DataSource & Delegate
extension FridgeIngredientsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fridgeIngredientsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = fridgeIngredientsData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FridgeIngredientCell", for: indexPath
        ) as? FridgeIngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = [UIContextualAction]()
        
        let delete = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
            tableView.beginUpdates()
            self.fridgeIngredientsData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            if self.fridgeIngredientsData.isEmpty { self.hideSearchButton() }
            completion(true)
        }
        
        delete.image = UIImage(
            systemName: "trash",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )?
            .withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        
        delete.backgroundColor = UIColor(white: 1, alpha: 0)
    
        actions.append(delete)
        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Update of ResultsViewController from searchController
extension FridgeIngredientsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard let resultVC = searchController.searchResultsController as? ResultsViewController else { return }
        resultVC.delegate = self
        
        viewModel.fetchIngredients(startingWith: query)
        viewModel.ingredients.bind { [weak resultVC] ingredients in
            DispatchQueue.main.async {
                resultVC?.update(with: ingredients)
            }
        }
    }
}

// MARK: - ResultsViewController Delegate to retrieve and send ingredient to the list
extension FridgeIngredientsViewController: ResultsViewControllerDelegate {
    func didTapIngredient(with name: String) {
        searchController.searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: true)
        
        if !fridgeIngredientsData.contains(name) {
            fridgeIngredientsData.append(name)
            fridgeIngredientsTableView.reloadData()
            if !searchButton.isEnabled { showSearchButton() }
        }
    }
}
