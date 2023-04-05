//
//  AppearanceTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import UIKit

final class AppearanceTableViewCell: UITableViewCell {

    @IBOutlet private var appearanceLabel: UILabel!
        
    func configure(with model: AppearanceCellViewModel) {
        appearanceLabel.text = model.name
    }
}
