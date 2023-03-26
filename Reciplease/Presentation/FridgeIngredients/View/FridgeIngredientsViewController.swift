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
    private var menuButton: UIBarButtonItem!
    private var menu: UIMenu!
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initSearchButton()
        fridgeIngredientsTableView.dataSource = self
        fridgeIngredientsTableView.delegate = self
    }
        
    private func initSearchButton() {
        searchButton.alpha = 0.0
        searchButton.isEnabled = false
    }
    
    private func initNavigationBar() {
        initSearchController()
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "textColor")
    }
    
    private func initSearchController() {
        searchController.searchBar.autocapitalizationType = .words
        searchController.searchBar.placeholder = "What's in your fridge?"
        searchController.searchBar.tintColor = UIColor(named: "textColor")
    }
    
    // MARK: - Actions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
    }
}

// MARK: - fridgeIngredientsTableView DataSource
extension FridgeIngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - fridgeIngredientsTableView Delegate
extension FridgeIngredientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
