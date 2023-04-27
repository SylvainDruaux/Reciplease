//
//  UILabel+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import UIKit
import Foundation

extension UILabel {
    var lines: Int {
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight/charSize
        return lineCount
    }
    
    func configureText(_ text: String, size: CGFloat = 20.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor") ?? .darkGray,
                NSAttributedString.Key.font: UIFont(name: "SF Pro Text Regular", size: size) ?? .systemFont(ofSize: size),
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.accessibilitySpeechLanguage: "en"
            ]
        )
        self.attributedText = attributedString
    }
}
