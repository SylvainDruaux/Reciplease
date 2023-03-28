//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/03/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userInterfaceStyle = UserPreferences.userInterfaceStyle
        
        switch userInterfaceStyle {
        case "light":
            window?.overrideUserInterfaceStyle = .light
        case "dark":
            window?.overrideUserInterfaceStyle = .dark
        default:
            window?.overrideUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        }
        
        return true
    }
}
