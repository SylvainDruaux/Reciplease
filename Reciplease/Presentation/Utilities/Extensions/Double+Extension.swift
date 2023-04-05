//
//  Double+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/03/2023.
//

import Foundation

extension Double {
    var decimalNotation: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            formatter.maximumFractionDigits = 0
        }
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    var timeNotation: String {
        if self >= 60.0 {
            let hoursAndMinutes = self.minutesToHoursAndMinutes()
            let hours = hoursAndMinutes.hours
            let minutes = hoursAndMinutes.leftMinutes
            let hourNotation = hours > 1 ? "hrs" : "hr"
            if minutes > 0 {
                return "\(hours) \(hourNotation) + \(minutes) min"
            } else {
                return "\(hours) \(hourNotation)"
            }
        } else {
            return "\(self.decimalNotation) min"
        }
    }
    
    private func minutesToHoursAndMinutes() -> (hours: Int, leftMinutes: Int) {
        return (Int(self) / 60, (Int(self) % 60))
    }
}
