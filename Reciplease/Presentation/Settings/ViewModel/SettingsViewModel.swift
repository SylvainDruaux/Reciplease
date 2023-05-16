//
//  SettingsViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/03/2023.
//

import Foundation

struct SettingCellViewModel {
    let icon: String
    let title: String
    let details: String?
}

struct SettingViewModel {
    let cellsViewModel: [SettingCellViewModel]
    
    init() {
        self.cellsViewModel = SettingsOption.allCases.map {
            SettingCellViewModel.init(icon: $0.icon, title: $0.title, details: $0.details)
        }
    }
}
