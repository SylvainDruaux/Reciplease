//
//  UIView+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 29/03/2023.
//

import UIKit

extension UIView {
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradientLayer.type = .axial
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        self.layer.addSublayer(gradientLayer)
    }
}
