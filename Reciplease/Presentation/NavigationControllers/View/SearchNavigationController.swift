//
//  SearchNavigationController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class SearchNavigationController: UINavigationController {
    
    private static let storyboardName = "FridgeIngredientsView"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: SearchNavigationController.storyboardName, bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() as? FridgeIngredientsViewController else {
            return
        }
        self.setViewControllers([rootViewController], animated: false)
    }
}
