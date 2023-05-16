//
//  Float+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 03/04/2023.
//

import Foundation

extension Float {
    var decimalNotation: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            formatter.maximumFractionDigits = 0
        }
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
