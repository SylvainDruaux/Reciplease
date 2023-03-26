//
//  AppearanceTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import UIKit

class AppearanceTableViewCell: UITableViewCell {

    @IBOutlet var appearanceLabel: UILabel!
        
    func configure(with model: AppearanceCellViewModel) {
        appearanceLabel.text = model.name
    }
}
