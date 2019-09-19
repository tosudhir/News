//
//  Validation.swift
//  NewsFeed
//
//  Created by Sudhir on 18/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        if self.trimmed().count <= 7 {
            return false
        }
        return true
    }
    
    func trimmed() -> String {
        return trimmedLeft().trimmedRight()
    }
    
    func trimmedLeft(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted) {
            return String(self[range.lowerBound ..< endIndex])
        }
        
        return ""
    }
    
    func trimmedRight(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            return String(self[startIndex ..< range.upperBound])
        }
        
        return ""
    }
}
