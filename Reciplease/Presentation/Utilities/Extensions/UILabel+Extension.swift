//
//  UILabel+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import UIKit

extension UILabel {
    var lines: Int {
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight/charSize
        return lineCount
    }
}
