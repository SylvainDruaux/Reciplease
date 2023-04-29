//
//  AppearanceTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import UIKit

final class AppearanceTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private var appearanceLabel: UILabel!
    
    // MARK: - View
    func configure(with model: AppearanceCellViewModel) {
        appearanceLabel.text = model.name
    }
}
