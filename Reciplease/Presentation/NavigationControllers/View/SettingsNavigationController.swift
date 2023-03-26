//
//  SettingsNavigationController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import UIKit

class SettingsNavigationController: UINavigationController {

    private static let storyboardName = "SettingsView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: SettingsNavigationController.storyboardName, bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() as? SettingsViewController else {
            return
        }
        self.setViewControllers([rootViewController], animated: false)
    }
}
