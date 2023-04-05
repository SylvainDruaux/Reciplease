//
//  UIButton+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 28/03/2023.
//

import UIKit

extension UIButton {
    func show() {
        UIView.animate(withDuration: 1) { self.alpha = 1.0 }
        self.isEnabled = true
    }
    
    func hide() {
        UIView.animate(withDuration: 1) { self.alpha = 0.0 }
        self.isEnabled = false
    }
}
