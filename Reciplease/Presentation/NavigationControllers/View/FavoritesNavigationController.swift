//
//  FavoritesNavigationController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class FavoritesNavigationController: UINavigationController {
    
    private static let storyboardName = "RecipesView"
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        let storyboard = UIStoryboard(name: FavoritesNavigationController.storyboardName, bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() as? RecipesViewController else {
            return
        }
        self.setViewControllers([rootViewController], animated: false)
    }
}
