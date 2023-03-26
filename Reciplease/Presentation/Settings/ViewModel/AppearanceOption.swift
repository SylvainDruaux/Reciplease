//
//  AppearanceOption.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import Foundation

enum AppearanceOption: CaseIterable {
    case lightMode, darkMode, deviceSettings
    
    var name: String {
        switch self {
        case .lightMode:
            let lightModeTitle = NSLocalizedString("light_mode_title", comment: "Apply Light mode")
            return lightModeTitle
        case .darkMode:
            let darkModeTitle = NSLocalizedString("dark_mode_title", comment: "Apply Dark mode")
            return darkModeTitle
        case .deviceSettings:
            let deviceModeTitle = NSLocalizedString("device_mode_title", comment: "Apply Device settings")
            return deviceModeTitle
        }
    }
    
    var style: String {
        switch self {
        case .lightMode:
            return "light"
        case .darkMode:
            return "dark"
        case .deviceSettings:
            return "unspecified"
        }
    }
    
    var icon: String {
        switch self {
        case .lightMode:
            return "sun.min.fill"
        case .darkMode:
            return "moon.fill"
        case .deviceSettings:
            return "square.lefthalf.filled"
        }
    }
}
