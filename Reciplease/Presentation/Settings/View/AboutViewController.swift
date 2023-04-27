//
//  AboutViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 08/03/2023.
//

import UIKit

final class AboutViewController: UIViewController {
    
    @IBOutlet private var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aboutDescription = NSLocalizedString("about_description", comment: "Description for the About screen")
        descriptionLabel.configureText(aboutDescription)
    }
}
