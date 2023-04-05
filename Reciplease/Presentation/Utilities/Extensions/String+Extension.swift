//
//  String+Extension.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 04/04/2023.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
