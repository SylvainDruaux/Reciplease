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
        configureText()
    }
    
    func configureText() {
        let aboutDescription = NSLocalizedString("about_description", comment: "Description for the About screen")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(
            string: aboutDescription,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor") ?? .darkGray,
                NSAttributedString.Key.font: UIFont(name: "SF Pro Text Regular", size: 20.0) ?? .systemFont(ofSize: 20.0),
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.accessibilitySpeechLanguage: "en"
            ]
        )
        descriptionLabel.attributedText = attributedString
    }
}
