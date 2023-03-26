//
//  AppearanceViewModel.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import Foundation

struct AppearanceCellViewModel {
    let name: String
    let style: String
}

struct AppearanceViewModel {
    let cellsViewModel: [AppearanceCellViewModel]
    
    init() {
        self.cellsViewModel = AppearanceOption.allCases.map {
            AppearanceCellViewModel.init(name: $0.name, style: $0.style)
        }
    }
}
