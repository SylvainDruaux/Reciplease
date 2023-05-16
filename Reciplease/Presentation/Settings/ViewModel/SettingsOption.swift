//
//  SettingsOption.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/03/2023.
//

import Foundation

enum SettingsOption: CaseIterable {
    case about, appearance
    
    private func setAppearance() -> AppearanceOption {
        let userInterfaceStyle = UserPreferences.userInterfaceStyle
        switch userInterfaceStyle {
        case "light":
            return .lightMode
        case "dark":
            return .darkMode
        default:
            return .deviceSettings
        }
    }
    
    var icon: String {
        switch self {
        case .about:
            return "info.circle.fill"
        case .appearance:
            return setAppearance().icon
        }
    }
    
    var title: String {
        switch self {
        case .about:
            let aboutTitle = NSLocalizedString("about_title", comment: "About this app")
            return aboutTitle
        case .appearance:
            let appearanceTitle = NSLocalizedString("appearance_title", comment: "Change the appearance")
            return appearanceTitle
        }
    }
    
    var details: String? {
        switch self {
        case .about:
            return nil
        case .appearance:
            return setAppearance().name
        }
    }
}
