//
//  SettingsTableViewCell.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 07/03/2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailsLabel: UILabel!
    
    func configure(with model: SettingCellViewModel) {
        iconImageView.image = UIImage(systemName: model.icon)
        titleLabel.text = model.title
        guard let details = model.details else {
            detailsLabel.isHidden = true
            return
        }
        detailsLabel.text = details
    }
}
