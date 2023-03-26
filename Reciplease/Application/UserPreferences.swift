//
//  UserPreferences.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 15/03/2023.
//

import Foundation

struct UserPreferences {
    private static let userInterfaceStyleKey = "userInterfaceStyle"
    private static let defaults = UserDefaults.standard

    static var userInterfaceStyle: String? {
        get { return defaults.string(forKey: userInterfaceStyleKey) }
        set { defaults.set(newValue, forKey: userInterfaceStyleKey) }
    }
}
